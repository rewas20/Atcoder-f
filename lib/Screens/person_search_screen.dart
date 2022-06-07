
import 'package:attendance/Models/leader.dart';
import 'package:attendance/Models/person.dart';
import 'package:attendance/Provider/db_provider.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  List<PersonModel> listPersons;
  SearchScreen(this.listPersons, {Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchString = "";
  TextEditingController inputText = TextEditingController(text: "");
  List<PersonModel> result =[];
  Widget buildSearchBar(BuildContext context){
    return SafeArea(
      child:  Material(
        color: Theme.of(context).primaryColor,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: TextFormField(
            controller: inputText,
            onChanged: (String){
              setState(() {
                result = widget.listPersons.where((element) =>
                (element.name.toLowerCase().contains(String.toLowerCase()))||(element.name.toUpperCase().contains(String.toUpperCase()))).toList();
              });
            },
            decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColor,
              filled: true,
              hintText: 'Search.....',
              hintStyle: TextStyle(color: Colors.black38,fontSize: 20),
              contentPadding: EdgeInsets.all(5),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close,size: 20,color: Colors.black,),
              ),
            ),
            autofocus: true,
          ),
        ),
      ),
    );
  }
  Widget buildBody(BuildContext context,String person){
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (_,index){
        return Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(result[index].name,style: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor),),
                    IconButton(onPressed: () async {
                      showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
                      await DatabaseProvider.instance.deletePerson(result[index].id!);
                      setState((){
                        result.remove(result[index]);
                      });
                      Navigator.pop(context);
                    }, icon: Icon(Icons.delete,size: 20,)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = widget.listPersons;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            toolbarHeight: 70,
            title: Text("Result",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            centerTitle: true,


          ),
          body: buildBody(context,inputText.text),
        ),
        Positioned(
          child: buildSearchBar(context),
          top: 0,
          left: 0,
          right: 0,
          height: 110,

        ),
      ],
    );
  }

}
