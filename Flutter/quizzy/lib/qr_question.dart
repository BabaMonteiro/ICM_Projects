import 'package:flutter/material.dart';
import 'package:quizzy/app_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeQuestion extends StatefulWidget {
  const QrCodeQuestion({Key? key}) : super(key: key);

  @override
  _QrCodeQuestionState createState() => _QrCodeQuestionState();
}

class _QrCodeQuestionState extends State<QrCodeQuestion> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
                borderColor: Colors.red,
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
                  : Text('Scan a QR code', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
