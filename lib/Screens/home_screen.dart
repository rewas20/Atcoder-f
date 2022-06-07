import 'package:attendance/Provider/db_provider.dart';
import 'package:attendance/Screens/DivideScreens/category_home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HOME_SCREEN";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  initState(){
    super.initState();
    refresh();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atcoder",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: const CategoriesDivideScreen(),
    );
  }

  refresh() async {
    await DatabaseProvider.instance.database;
  }
}

