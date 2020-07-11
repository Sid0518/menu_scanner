import'imports.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
          FileUploadPage(),
        ],
      ),
    );
  }
}
