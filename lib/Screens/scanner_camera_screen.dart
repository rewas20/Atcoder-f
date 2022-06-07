import 'package:attendance/Models/qr_overlay.dart';
import 'package:attendance/Provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScannerCameraScreen extends StatefulWidget {
  static const routeName = "SCANNER_CAMERA_SCREEN";
  const ScannerCameraScreen({Key? key}) : super(key: key);

  @override
  State<ScannerCameraScreen> createState() => _ScannerCameraScreenState();
}
class _ScannerCameraScreenState extends State<ScannerCameraScreen> {
  MobileScannerController cameraController = MobileScannerController();
  int counter = 0;
  @override

  void dispose(){
    super.dispose();
    cameraController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan code",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: (){
                cameraController.switchCamera();
              },
              icon: const Icon(Icons.camera_rear_outlined)
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcode,args) async {
              counter++;
              try{
                if(counter == 1) {
                  cameraController.dispose();
                Navigator.of(context).pop(barcode.rawValue);

                }
              }catch(e){
                Fluttertoast.showToast(msg: "scan again");
              }

            },
            allowDuplicates: false,

          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}