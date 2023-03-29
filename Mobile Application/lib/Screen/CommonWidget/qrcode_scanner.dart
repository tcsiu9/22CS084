import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrcodeScanner extends StatefulWidget {
  final String route_uuid;

  const QrcodeScanner({Key? key, required this.route_uuid})
      : assert(route_uuid != null),
        super(key: key);

  @override
  State<QrcodeScanner> createState() => _QrcodeScannerState(route_uuid);
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  String route_uuid;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  _QrcodeScannerState(this.route_uuid);

  @override
  Widget build(BuildContext context) {
    // if (controller != null && mounted) {
    //   controller!.pauseCamera();
    //   controller!.resumeCamera();
    // }
    return Scaffold(
        appBar: AppBar(),
        body: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8,
          ),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((event) {
      setState(() {
        if (event.code != null) {
          controller.pauseCamera();
          BlocProvider.of<RouteBloc>(context).add(RouteStatusUpdate(
              scanData: event.code ?? '', route_uuid: route_uuid));
          Navigator.of(context).pop();
          // BlocProvider.of<TaskStatusBloc>(context)
          //     .add(TaskStatusRefreshed(route_uuid: route_uuid));
        }
      });
    });
  }
}
