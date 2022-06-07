import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:attendance/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "HOME_SCREEN";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Lottie.asset('assets/lotties/qr-scan.json'),
        nextScreen:  const HomeScreen(),
        backgroundColor: Theme.of(context).primaryColor,
        disableNavigation: false,
        splashIconSize: double.infinity,
        duration: 2000,
      ),
    );
  }
}
