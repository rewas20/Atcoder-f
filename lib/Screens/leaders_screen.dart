import 'package:attendance/Models/leader.dart';
import 'package:attendance/Models/search_bar.dart';
import 'package:attendance/Provider/db_provider.dart';
import 'package:attendance/Screens/add_name_screen.dart';
import 'package:attendance/Screens/leader_search_screen.dart';
import 'package:attendance/Widgets/name_item.dart';
import 'package:flutter/material.dart';

class LeadersScreen extends StatefulWidget {
  static const routeName = "LEADERS_SCREEN";
  const LeadersScreen({Key? key}) : super(key: key);

  @override
  State<LeadersScreen> createState() => _LeadersScreenState();
}

class _LeadersScreenState extends State<LeadersScreen>with TickerProviderStateMixin {
   late AnimationController animationController ;
   List<LeaderModel> listAllLeaders =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
      vsync: this,

    )..addListener(() {
      setState(() {

      });
    });

  }
  void openSearchBar() async{
    await animationController.animateTo(1,curve: Curves.easeInOutQuart).orCancel;
    await Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,_,__)=> SearchScreen(listAllLeaders)));
    closeSearchBar();
  }
  void closeSearchBar() async{
    await animationController.animateBack(0,curve: Curves.easeInOutQuart).orCancel;
  }

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            toolbarHeight: 70,
            title: Text(listAllLeaders==null||listAllLeaders.isEmpty?name:"$name (${listAllLeaders.length})",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                onPressed: (){
                  openSearchBar();
                },
                icon: Icon(Icons.search),

              ),
              IconButton(
                onPressed: (){
                  setState((){
                    listAllLeaders;
                  });
                },
                icon: Icon(Icons.format_list_numbered_rtl),

              )
            ],
          ),
          body: StreamBuilder(
            stream: DatabaseProvider.instance.readAllLeaders().asStream(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = snapshot.data as List<LeaderModel>;
                if(data.isNotEmpty){
                    listAllLeaders = data;
                }
              }
              return listAllLeaders!=null&&listAllLeaders.isNotEmpty?RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: listAllLeaders.length,
                  itemBuilder: (_,index){
                    return Card(
                      margin: EdgeInsets.all(10),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      shadowColor: Theme.of(context).primaryColor,
                      child: NameItem(id: listAllLeaders[index].id,name: listAllLeaders[index].name, gender: listAllLeaders[index].gender, typeUser: listAllLeaders[index].typeUser, deleteItem: (id) async {
                        showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
                        await DatabaseProvider.instance.deleteLeader(id);
                        setState((){
                          listAllLeaders.remove(listAllLeaders[index]);
                        });
                        Navigator.pop(context);
                      },),
                    );
                  },
                ),
              ):Center(child: Container(alignment: Alignment.center,child: Text("No data",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),),);
            },
          ),
          floatingActionButton: Container(
            margin: const EdgeInsets.all(20),
            child: FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(AddNameScreen.routeName,arguments: {
                  "typeUser":"leader",
                });
                setState((){
                  listAllLeaders.clear();
                });
              },
              child: const Icon(Icons.add,size: 25,),
            ),
          ),
        ),
        Positioned(
          child: buildSearchBar(context),
          top: 0,
          left: 0,
          right: 0,
          height: 110,

        ),
      ]
    );
  }

  Widget buildSearchBar(BuildContext context){
    return SafeArea(
      child: ClipPath(
        clipper: SearchBarClipArea(animationController.value * 1.01),
        child: Material(

          color: Theme.of(context).primaryColor,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                contentPadding: EdgeInsets.all(5),
                hintText: 'Search.....',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black38,fontSize: 20),
                suffixIcon: IconButton(
                  onPressed: (){
                    closeSearchBar();
                  },
                  icon: Icon(Icons.close),
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

   Future onRefresh() async{
     await Future.delayed(Duration(seconds: 2));
     setState(() {

       listAllLeaders.clear();
     });
   }
}
