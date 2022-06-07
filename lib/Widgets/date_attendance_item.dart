import 'package:attendance/Models/attendance.dart';
import 'package:attendance/Provider/db_provider.dart';
import 'package:attendance/Screens/view_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DateAttendanceItem extends StatelessWidget {
  final String date;
  Function(String) onOpen;

   DateAttendanceItem({Key? key,
    required this.date,
    required this.onOpen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qur = MediaQuery.of(context).size.width/4;
    return InkWell(
      onTap: () async {
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text("فتح في اكسل؟"),
          titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsPadding: EdgeInsets.all(10),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          alignment: Alignment.center,
          actions: [
            TextButton(
                onPressed: (){

                  Navigator.pop(context);
                  onOpen(date);
                  Fluttertoast.showToast(msg: "تم");
                },
                child: Text("نعم",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800))
            ),
            TextButton(
                onPressed: (){

                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(ViewAttendanceScreen.routeName,arguments: date);
                },
                child: Text("لا",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,)
            ),
          ],
        ));

      },
      onLongPress: () async {
        List<AttendanceModel> allAttendance = await DatabaseProvider.instance.readAllAttendTime(date);
        var data =" اجتماع($date)(${allAttendance.length})\n===========\nافراد\n=========";
        var leader ="\n===========\nقادة\n=========";
        var boys ="\n===========\nولاد\n=========";
        var girls ="\n===========\nبنات\n=========";
        var counterPerson = 0;
        var counterLeader = 0;
        var counterMale = 0;
        var counterFemale = 0;
        allAttendance.forEach((type) {

          if(type.typeUser=="فرد"){
            counterPerson++;
            data = "$data\n $counterPerson.\t${type.name}\t => ${type.time}";
          }else if(type.typeUser=="قائد") {
            counterLeader++;
            leader = "$leader\n $counterLeader.\t${type.name}\t => ${type.time}\t";
          }
        });
        allAttendance.forEach((gender) {

          if(gender.gender=="male"){
            counterMale++;
            boys = "$boys\n $counterMale.\t${gender.name}\t => ${gender.time}";
          }else if(gender.gender=="female") {
            counterFemale++;
             girls = "$girls\n $counterFemale.\t${gender.name}\t => ${gender.time}\t";
          }
        });

        Clipboard.setData(ClipboardData(text: data+leader+"\n\n"+boys+girls));
        Fluttertoast.showToast(msg: "تم النسخ");

      },
      borderRadius: BorderRadius.circular(25),
      focusColor: Colors.black,
      splashColor: Colors.black,
      child:  Container(
        height: 100,
        width: qur*1.5,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.7),
              Colors.white.withOpacity(0.6),
              Theme.of(context).primaryColor.withOpacity(0.6)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.lightBlueAccent,
                blurRadius: 100,
                blurStyle: BlurStyle.inner
            )
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(date,style:  TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black.withOpacity(0.5))),
      ),
    );
  }
}