import 'dart:convert';
import 'dart:io';
import 'package:attendance/Models/attendance.dart';
import 'package:attendance/Screens/videw_attend_date_screen.dart';
import 'package:attendance/Widgets/date_attendance_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../Provider/db_provider.dart';

class AttendanceScreen extends StatefulWidget {
  static const routeName = "ATTENDANCE_SCREEN";
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<String>listAllDate=[];
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(ViewAttendDateScreen.routeName).then((value) => listAllDate.clear());
              },
              icon: Icon(Icons.delete,size: 25,)
          )
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readAllAttendByDate().asStream(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data as List<String>;
            if(data.isNotEmpty){
              listAllDate =data;
            }
          }
          return listAllDate!=null&&listAllDate.isNotEmpty?RefreshIndicator(child: GridView(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
              childAspectRatio: 4/3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: listAllDate.map((caData) => DateAttendanceItem(date: caData, onOpen: (date) async {
              showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(),));
              setState((){
                //listAllAttendance = listAttends;
                sheetExcel(date);
              });
            }) ).toList(),

          ), onRefresh: onRefresh):Center(child: Container(alignment: Alignment.center,child: Text("No data",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),),);
        },
      ),
    );
  }
  Future sheetExcel(date) async{
    List<AttendanceModel> attends = await DatabaseProvider.instance.readAllAttendTime(date);
    final Workbook workbook =  Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText("الوقت");
    sheet.getRangeByName('B1').setText("الاسم");
    sheet.getRangeByName('C1').setText("الرتبه");
    int numberRow = 2;
    for (var element in attends) {
      sheet.getRangeByName('A${numberRow}').setText(element.time);
      sheet.getRangeByName('B${numberRow}').setText(element.name);
      sheet.getRangeByName('C${numberRow}').setText(element.typeUser);
      numberRow++;
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final time = date.replaceAll("/", "-");
    if(kIsWeb){
      AnchorElement(href: 'data:application/octet-srteam;charset=utf-16le;based64,${base64.encode(bytes)}')
        ..setAttribute('download', "Agtma3($time).xlsx")..click();
      Navigator.pop(context);
    }else{
      final String path =(await getApplicationSupportDirectory()).path;
      final String fileName = "$path/Agtma3($time).xlsx";
      try{
        await File(fileName).writeAsBytes(bytes,flush: true);
      }on FileSystemException catch(e){
        Fluttertoast.showToast(msg: "wrong");
      }
       OpenFile.open(fileName);
      Navigator.pop(context);
    }
  }

 Future onRefresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {

      listAllDate.clear();
    });
  }


}