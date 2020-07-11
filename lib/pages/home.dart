import 'package:menu_scanner/imports.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/*
  -> HomePage is a Stateful widget with this scary-sounding 
  'SingleTickerProviderStateMixin'
  -> But this is all pretty much boilerplate code - the TabBarView
  needs this stuff, otherwise it doesn't work
  -> IDK why it needs it, but it does, and I don't question it
*/
class _HomePageState extends State<HomePage> 
with SingleTickerProviderStateMixin {

  TabController tabController;
  final AuthService auth = AuthService();

  // Use AuthService to get the logged-in user
  Future<void> login(BuildContext context) async {
    User user = Provider.of<User>(context, listen: false);
    FirebaseUser firebaseUser = await this.auth.getUser;

    if (firebaseUser != null && user.firebaseUser == null) {
      user.firebaseUser = firebaseUser;
    }
  }

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);

    this.login(context);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Scanner'),
        bottom: TabBar(
          controller: this.tabController,
          tabs: [
            Tab(text: 'SCAN'), 
            Tab(text: 'UPLOAD')
          ]
        ),
      ),

      /*
        The second page of TabBarView is based on the login state
        If the user is logged in, then the FileUploadPage is shown,
        otherwise a SignInPage is shown
      */
      body: TabBarView(
        controller: this.tabController,
        children: [
          ScannerPage(),
          user.firebaseUser != null ? FileUploadPage() : SignInPage(),
        ],
      ),
    );
  }
}
