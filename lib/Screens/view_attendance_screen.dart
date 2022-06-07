import 'package:attendance/Models/attendance.dart';
import 'package:attendance/Models/search_bar.dart';
import 'package:attendance/Provider/db_provider.dart';
import 'package:attendance/Screens/attendance_search_screen.dart';
import 'package:attendance/Widgets/name_item.dart';
import 'package:flutter/material.dart';

class ViewAttendanceScreen extends StatefulWidget {
  static const routeName = "VIEW_ATTENDANCE_SCREEN";
  const ViewAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen>  with TickerProviderStateMixin{
  late AnimationController animationController ;
  List<AttendanceModel> listAllAttendance =[];
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
    await Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,_,__)=> SearchScreen(listAllAttendance)));
    closeSearchBar();
  }
  void closeSearchBar() async{
    await animationController.animateBack(0,curve: Curves.easeInOutQuart).orCancel;
  }

  @override
  Widget build(BuildContext context) {
    final date = ModalRoute.of(context)!.settings.arguments as String;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            toolbarHeight: 70,
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
                    listAllAttendance;
                  });
                },
                icon: Icon(Icons.format_list_numbered_rtl),

              )
            ],
            title: Text(listAllAttendance==null||listAllAttendance.isEmpty?date:"$date (${listAllAttendance.length})",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          body: StreamBuilder(
            stream: DatabaseProvider.instance.readAllAttendTime(date).asStream(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = snapshot.data as List<AttendanceModel>;
                if(data.isNotEmpty){
                  listAllAttendance = data;
                }
              }
              return listAllAttendance!=null&&listAllAttendance.isNotEmpty?RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: listAllAttendance.length,
                  itemBuilder: (_,index){
                    return Card(
                      margin: EdgeInsets.all(10),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      shadowColor: Theme.of(context).primaryColor,
                      child: NameItem(id: listAllAttendance[index].id,time: listAllAttendance[index].time,name: listAllAttendance[index].name, gender: listAllAttendance[index].gender, typeUser: listAllAttendance[index].typeUser, deleteItem: (id) async {
                        showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
                        await DatabaseProvider.instance.deleteAttend(id);
                        setState((){
                          listAllAttendance.remove(listAllAttendance[index]);
                        });
                        Navigator.pop(context);
                      },),
                    );
                  },
                ),
              ):Center(child: Container(alignment: Alignment.center,child: Text("No data",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),),);

              },
          ),
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

      listAllAttendance.clear();
    });
  }
}
