import 'package:flutter/material.dart';
import 'package:quizzy/app_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class QrCodeQuestion extends StatefulWidget {
  const QrCodeQuestion({Key? key}) : super(key: key);
  

  @override
  _QrCodeQuestionState createState() => _QrCodeQuestionState();
}

class _QrCodeQuestionState extends State<QrCodeQuestion> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showQrCodeDialog(context);
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _showQrCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Found Our QR Code?',
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 78, 13, 151),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 3),
                      backgroundColor: const Color(0xFFFF8675),
                    ),
                    icon: const Icon(Icons.arrow_right_alt),
                    label: const Text('SCAN IT!'),
                    
                  )
                ],
              ),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuizzyAppBar(height: AppBar().preferredSize.height),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Color.fromARGB(255, 78, 13, 151),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Result: ${result!.code}',
                      style: TextStyle(fontSize: 18),
                    )
                  : Text('Found a question? Scan It!', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
