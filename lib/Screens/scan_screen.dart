import 'package:attendance/Models/attendance.dart';
import 'package:attendance/Models/leader.dart';
import 'package:attendance/Models/person.dart';
import 'package:attendance/Provider/db_provider.dart';
import 'package:attendance/Screens/scanner_camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ScanScreen extends StatefulWidget {
  static const routeName = "SCAN_SCREEN";
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String formatDate  = DateFormat("dd/MM/yyyy").format(DateTime.now());
  String formatTime  = DateFormat("h:mm a").format(DateTime.now());
  var scan = "" ;
  var resultScan = "" ;
  @override
  Widget build(BuildContext context) {
    final qur = MediaQuery.of(context).size.width/4;
    final name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Text(scan!=null&&scan!=""?scan:"No Selected",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),
              SizedBox(height: qur),
              ElevatedButton.icon(
                  onPressed: () async {
                    try{
                    var result  = await Navigator.of(context).pushNamed(ScannerCameraScreen.routeName);
                      if(result!=null&&result.toString().length>1){
                        resultScan = result as String;
                        var scanName = resultScan.toString().substring(0,resultScan.toString().length-1);
                        var scanCode = resultScan.toString().substring(resultScan.toString().length-1,resultScan.toString().length);
                        if(scanCode=="1"||scanCode=="2"){
                          setState((){
                            scan = scanName;
                          });
                          showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator(),),barrierDismissible: false);
                            await checkCode(scanName, scanCode,context);

                        }else{
                         Fluttertoast.showToast(msg: "ليس موجود في البيانات"+" "+resultScan);
                          setState((){
                            scan = result;
                          });
                        }
                      }else{
                        setState((){
                          scan = "No Selected";
                        });
                      }
                    }catch(e){
                      Navigator.pop(context);
                    }

                  },
                icon: const Icon(Icons.qr_code_scanner,size: 25,),
                label: const Text("Scan",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future checkCode(scanName,scanCode,BuildContext context) async {
    switch (scanCode){
      case '1':
        LeaderModel model = await DatabaseProvider.instance.readLeadersByName(scanName);
        if(model!=null){
          bool attend = await DatabaseProvider.instance.checkAttend(model.name,formatDate);
          if(attend){
            Fluttertoast.showToast(msg: "مسجل من قبل"+" "+model.name+" "+model.typeUser);
            Navigator.pop(context);
          }else{
            await DatabaseProvider.instance.createAttend(AttendanceModel(name: model.name, gender: model.gender, typeUser: model.typeUser, date: formatDate, time: formatTime));
            Fluttertoast.showToast(msg: "${model.name} تم تسجيل");
            Navigator.pop(context);
          }
        }else{
          Fluttertoast.showToast(msg: "ليس موجود في البيانات"+" "+scanName);
          Navigator.pop(context);
        }
        break;
      case '2':
        PersonModel model = await DatabaseProvider.instance.readPersonByName(scanName);
        if(model!=null){
          bool attend = await DatabaseProvider.instance.checkAttend(model.name,formatDate);
          if(attend){
            Fluttertoast.showToast(msg: "مسجل من قبل"+" "+model.name);
            Navigator.pop(context);
          }else{
            await DatabaseProvider.instance.createAttend(AttendanceModel(name: model.name, gender: model.gender, typeUser: model.typeUser, date: formatDate, time: formatTime));
            Fluttertoast.showToast(msg: "${model.name} تم تسجيل");
            Navigator.pop(context);
          }
        }else{
          Fluttertoast.showToast(msg: "ليس موجود في البيانات"+" "+scanName);
          Navigator.pop(context);
        }
        break;
      default:
        Fluttertoast.showToast(msg: "ليس موجود في البيانات"+" "+scanName);
        Navigator.pop(context);
        break;
    }
  }

}
