import 'package:attendance/Models/leader.dart';
import 'package:attendance/Models/person.dart';
import 'package:attendance/Provider/db_provider.dart';
import 'package:attendance/Screens/scanner_camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNameScreen extends StatefulWidget {
  static const routeName = "ADD_NAME_SCREEN";
  const AddNameScreen({Key? key}) : super(key: key);

  @override
  State<AddNameScreen> createState() => _AddNameScreenState();
}

class _AddNameScreenState extends State<AddNameScreen> {
  GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  List<String> items = ["ولد","بنت"];
  String selected="ولد";
  var exist = false;
  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    if(model["typeUser"]!='leader'){
      selected = model["typeUser"];
      items = [model["typeUser"]];
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text("Add Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                var result = await Navigator.of(context).pushNamed(ScannerCameraScreen.routeName);
                showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(),),barrierDismissible: false);
                setTitle(result,context);
              },
              icon: const Icon(Icons.qr_code_scanner,size: 25,)
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKeyAdd,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.drive_file_rename_outline,size: 20,),
                      hintText: "الاسم",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.text,
                      validator: (value){
                        if(value==null||value==""||value.toString().length < 2){
                          return "مطلوب";
                        }else if(exist){
                          return "موجود بالفعل $value";
                        }
                      }
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField(
                          elevation: 16,
                          value: selected,
                          onChanged: (String? value) {
                            setState((){
                              selected = value!;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                          items: items
                            .map((item) {
                              return DropdownMenuItem<String>(
                                value:  item,
                                child: Text(item,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColor)),
                              );
                            }).toList(),

                          validator: (value){
                            if(value==null||value==" "){
                              return "اختار";
                            }
                          },

                        ),
                      ),
                      const Text("النوع",style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black))
                    ],
                  )

                ],
              ),
            ),
          ),

        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () async {
            showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
            if(model["typeUser"]=='leader'){
              exist = await DatabaseProvider.instance.checkLeader(nameController.text);
            }else {
              exist = await DatabaseProvider.instance.checkPerson(nameController.text);
            }
            Navigator.pop(context);
            if(formKeyAdd.currentState!.validate()){
              showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
              add(model,context);
            }
            //createObject
            //add database and pop
          },
          child: const Icon(Icons.save_rounded,size: 25,),
        ),
      ),
    );
  }
  add(model,BuildContext context) async {
    var gender = selected=="ولد"? "male":"female";
    try {
      if (model["typeUser"] == "leader") {
        await DatabaseProvider.instance.createLeader(LeaderModel(
            name: nameController.text.toString(),
            gender: gender,
            typeUser: "قائد"));
      } else {
        await DatabaseProvider.instance.createPerson(PersonModel(
            name: nameController.text.toString(),
            gender: gender,
            typeUser: "فرد"));
      }
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "تم الاضافة");
      Navigator.of(context).pop();
    }catch(e){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "حاول مره اخري");
    }
  }

  void setTitle(result,BuildContext context) {
    try{
    var resultScan= "";
    if(result!=null&&result.toString().length>1){
      resultScan = result as String;
      var scanName = resultScan.toString().substring(0,resultScan.toString().length-1);
      var scanCode = resultScan.toString().substring(resultScan.toString().length-1,resultScan.toString().length);
      if(scanCode=="1"||scanCode=="2"){
        setState((){
          nameController.text = scanName;
        });
      }else{
        Fluttertoast.showToast(msg: "qr خطاء");
      }
    }
    Navigator.pop(context);
    }catch(e){
      Navigator.pop(context);
      Fluttertoast.showToast(msg:"حاول مره اخري");
    }
  }
}
