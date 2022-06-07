import 'package:attendance/Provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NameItem extends StatelessWidget {
  final int? id;
  final String name;
  final String gender;
  final String typeUser;
  final String? time;
  Function(int) deleteItem;

   NameItem({Key? key,
    this.id,
    this.time,
    required this.name,
    required this.gender,
    required this.typeUser,
    required this.deleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){

      },
      contentPadding: EdgeInsets.all(15),
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(name,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),
      leading: Text(typeUser,),
      subtitle: Text(time==null||time==""?"":time!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.black),),
      trailing: IconButton(
          onPressed: (){
            if(typeUser=="فرد"){

              showDialog(context: context, builder: (context)=>alertDialog(context));
            }else if(typeUser=="قائد"){

              showDialog(context: context, builder: (context)=>alertDialog(context));
            }
          },
          icon: Icon(Icons.delete,size: 25,)),
    );
  }
  alertDialog(context){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: const Text("هل تريد المسح ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: [
        TextButton(onPressed: () async {
          deleteItem(id!);
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "تم");
        },
          child: const Text("نعم",style: TextStyle(fontSize: 20),),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "الغاء");
        },
          child: const Text("لا",style: TextStyle(fontSize: 20)),

        ),
      ],
    );
  }
}
