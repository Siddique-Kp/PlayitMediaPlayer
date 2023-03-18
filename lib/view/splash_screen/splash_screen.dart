import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playit/view/main_page/main_page.dart';

import '../../controller/videos/access_video_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // gotoHome();
    Timer(const Duration(seconds: 3), () {
      videoFetch();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.white,
    //   statusBarColor: Colors.white,
    // ));

    return Scaffold(
      body: Center(
          child: SvgPicture.asset(
        'assets/launch_image.svg',
        width: 150,
        height: 150,
      )),
    );
  }

  // gotoHome() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   navigatePage();
  // }

  // navigatePage() {
  //   Navigator.pushReplacementNamed(context, '/VideoPage');
  // }
}
