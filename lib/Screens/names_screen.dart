import 'package:attendance/Data/data.dart';
import 'package:attendance/Widgets/category_item.dart';
import 'package:flutter/material.dart';

class NamesScreen extends StatefulWidget {
  static const routeName = "NAMES_SCREEN";
  const NamesScreen({Key? key}) : super(key: key);

  @override
  State<NamesScreen> createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: CATEGORY_NAMES.map((caData) => CategoryItem(name: caData.name, routeName: caData.routeName) ).toList(),

      ),
    );
  }
}
