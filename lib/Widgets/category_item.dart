import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  String name;
  String routeName;

  CategoryItem({Key? key,
    required this.name,
    required this.routeName
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final qur = MediaQuery.of(context).size.width/4;
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(routeName,
            arguments: name
        );
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
        child: Text(name,style:  TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black.withOpacity(0.5))),
      ),
    );
  }
}
