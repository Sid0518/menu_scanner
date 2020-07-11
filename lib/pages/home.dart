import 'package:menu_scanner/imports.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
with SingleTickerProviderStateMixin {

  TabController tabController;
  final AuthService auth = AuthService();

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
