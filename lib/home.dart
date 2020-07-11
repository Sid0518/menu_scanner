import'imports.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu Scanner'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'SCAN'),
              Tab(text: 'UPLOAD')
            ]
          ),
        ),

        body: TabBarView(
          children: [
            ScannerPage(),
            FileUploadPage(),
          ],
        ),
      ),
    );
  }
}
