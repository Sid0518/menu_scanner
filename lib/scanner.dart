import 'imports.dart';

class ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Tap on the camera icon to scan a QR Code',

            style: TextStyle(
              fontSize: 24,
            ),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),

        onPressed: () async {
          var scan = await BarcodeScanner.scan();
          String url = scan.rawContent;

          if(scan.type == ResultType.Barcode) {
            if(await canLaunch(url))
              launch(url);

            else
              showDialog(
                  context: context,

                  child: AlertDialog(
                    title: Text(
                        'Invalid QR Code\nDoes not point to a valid URL'
                    ),
                  )
              );
          }
        },
      ),
    );
  }
}