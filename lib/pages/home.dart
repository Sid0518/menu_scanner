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

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
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
            Tab(text: 'UPLOAD'), 
            Tab(text: 'SCAN')
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
          FileUploadPage(),
          ScannerPage(),
        ],
      ),

      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: 8
                    ),

                    child: CircleAvatar(
                      backgroundImage:
                        NetworkImage(user.firebaseUser.photoUrl),
                    ),
                  ),

                  Text(
                    user.name,
                    
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    user.email,
                    
                    style: TextStyle(
                      color: Colors.black54,
                    )
                  )
                ],
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.subdirectory_arrow_left),
              
              title: Text(
                'Log Out',
                
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),

              onTap: () async {
                await this.auth.signOut();
                user.signOut();

                Navigator.pushReplacement(context, 
                  MaterialPageRoute(
                    builder: (context) => 
                      SignInPage()
                  )
                );
              },
            )
          ],
        )
      ),
    );
  }
}
