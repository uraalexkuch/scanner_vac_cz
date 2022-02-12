import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void dispose() {
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Сканер вакансій"),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                elevation: 10.0,
                onPressed: () {
                  Get.toNamed('/Home');
                },
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(35.0)),
                  side: BorderSide(color: HexColor('#FFD947'), width: 3),
                ),
                color: HexColor("#005BAA"),
                child: Column(
                  children: [
                    Text(
                      "Завершити роботу",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: HexColor('#FFFFFF'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      if (scanData.code != null) {
        //await controller.toggleFlash();
        //await launch(scanData.code!.substring(0, 55).trim());
        String intext = (scanData.code!.substring(55));
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Короткі дані'),
              content: SingleChildScrollView(
                  child: ListBody(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor('#FFD947'), width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      intext,
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                )
              ])),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Отримати повну інформацію',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Get.toNamed('/Home/web',
                        arguments: scanData.code!.substring(3, 55).trim());
                  },
                ),
                TextButton(
                  child: const Text(
                    'Повернутися',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Get.toNamed('/Home');
                    controller.pauseCamera();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
        if (kDebugMode) {
          print("camera: ${scanData.code!.substring(3, 55)}");
        }
        //await launch(scanData.code!.substring(0, 55));
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code!.substring(55)}'),
                    //Text('Data: ${scanData.code!.substring(0, 55)}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }
}
