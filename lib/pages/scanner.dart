import 'package:menu_scanner/imports.dart';

class ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Icon(Icons.camera),
        
        onPressed: () async {
          /*
            -> BarcodeScanner.scan() is a method defined in the
            barcode-scan package, which opens a new page with
            the user's camera open, and tries to scan a QR Code
            -> If successful, we can get the string encoded in the
            QR Code by using the 'rawContent' of the scan object
          */
          var scan = await BarcodeScanner.scan();

          if (scan.type == ResultType.Barcode) {
            String url = scan.rawContent;

            /*
              canLaunch() and launch() are defined in url_launcher
              package
              launch() attempts to open the passed URL in a browser
              on the user's device
            */
            if (await canLaunch(url))
              launch(url);
            else
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('Invalid QR Code\nDoes not point to a valid URL'),
                )
              );
          }
        },
      ),
    );
  }
}
