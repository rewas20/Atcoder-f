
import 'package:attendance/Screens/add_name_screen.dart';
import 'package:attendance/Screens/attendance_screen.dart';
import 'package:attendance/Screens/boys_screen.dart';
import 'package:attendance/Screens/girls_screen.dart';
import 'package:attendance/Screens/home_screen.dart';
import 'package:attendance/Screens/leaders_screen.dart';
import 'package:attendance/Screens/names_screen.dart';
import 'package:attendance/Screens/scan_screen.dart';
import 'package:attendance/Screens/scanner_camera_screen.dart';
import 'package:attendance/Screens/splash_screen.dart';
import 'package:attendance/Screens/videw_attend_date_screen.dart';
import 'package:attendance/Screens/view_attendance_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atcoder',
      theme: ThemeData(
        primaryColor: const Color(0xff3490dc),
      ),
      routes: {
        '/': (context)=> const SplashScreen(),
        HomeScreen.routeName: (context)=> const HomeScreen(),
        ScanScreen.routeName: (context)=> const ScanScreen(),
        ScannerCameraScreen.routeName: (context)=> const ScannerCameraScreen(),
        NamesScreen.routeName: (context)=> const NamesScreen(),
        BoysScreen.routeName: (context)=> const BoysScreen(),
        GirlsScreen.routeName: (context)=> const GirlsScreen(),
        LeadersScreen.routeName: (context)=> const LeadersScreen(),
        AddNameScreen.routeName: (context)=> const AddNameScreen(),
        AttendanceScreen.routeName: (context)=> const AttendanceScreen(),
        ViewAttendDateScreen.routeName: (context)=> const ViewAttendDateScreen(),
        ViewAttendanceScreen.routeName: (context)=> const ViewAttendanceScreen(),
      },
    );
  }
}
