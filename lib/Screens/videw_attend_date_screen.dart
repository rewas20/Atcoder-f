import 'package:attendance/Provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewAttendDateScreen extends StatefulWidget {
  static const routeName = "VIEW_ATTEND_DATE_SCREEN";
  const ViewAttendDateScreen({Key? key}) : super(key: key);

  @override
  State<ViewAttendDateScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewAttendDateScreen> {
  List<String> listAllDate =[];
  List<String> listRemove = [];
  Icon iconCheck = Icon(Icons.check_box_outline_blank,size: 20);
  Icon iconCheckAll = Icon(Icons.check_box_outline_blank,size: 20);
  bool check = false;
  bool checkAll = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dates"),
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: (){
              if(checkAll){
                setState((){
                  iconCheck = Icon(Icons.check_box_outline_blank,size: 20);
                  iconCheckAll = Icon(Icons.check_box_outline_blank,size: 20);
                  checkAll = false;
                  check = false;
                  listRemove.clear();
                });
              }else{
                setState((){
                  iconCheck = Icon(Icons.check_box,size: 20);
                  iconCheckAll = Icon(Icons.check_box,size: 20);
                  checkAll = true;
                  check = true;
                  listRemove = listAllDate;
                });
              }
            },
            icon: iconCheckAll,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readAllAttendByDate().asStream(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data as List<String>;
            if(data.isNotEmpty){
              listAllDate = data;
            }
          }
          return listAllDate!=null&&listAllDate.isNotEmpty?RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
                itemCount: listAllDate.length,
                itemBuilder: (conxt,index){
                  return Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                      title: Text(listAllDate[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                      trailing: IconButton(
                        onPressed: (){
                          if(check){
                            setState((){
                              iconCheck = Icon(Icons.check_box_outline_blank,size: 20);
                              check = false;
                              listRemove.remove(listAllDate[index]);
                            });
                          }else{
                            setState((){
                              iconCheck = Icon(Icons.check_box,size: 20);
                              check = true;
                              listRemove.add(listAllDate[index]);
                            });
                          }
                        },
                        icon: iconCheck,
                      ),
                    ),
                  );
                }
            ),
          ):Center(child: Container(alignment: Alignment.center,child: Text("No Data"),),);
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: (){
            listRemove==null||listRemove.isEmpty?Fluttertoast.showToast(msg: "لا يوجد تحديد"):showDialog(context: context, builder: (context)=>AlertDialog(
              title: Text("هل انت متأكد ؟"),
              titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              actionsPadding: EdgeInsets.all(10),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              alignment: Alignment.center,
              actions: [
                TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
                    listRemove.forEach((element) async {
                      await DatabaseProvider.instance.deleteAttendByDate(element);
                    });
                    Fluttertoast.showToast(msg: "تم");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState((){
                      listAllDate.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("نعم")
                ),
                TextButton(
                  onPressed: (){
                    Fluttertoast.showToast(msg: "الغاء");
                    Navigator.pop(context);
                  },
                  child: Text("لا")
                ),
              ],
            ));
          },
          child: Icon(Icons.delete,size: 25,),
        ),
      ),
    );
  }
  Future onRefresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {

      listAllDate.clear();
    });
  }
}
