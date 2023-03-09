import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // videoFetch();
    gotoHome();
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

  gotoHome() async {
    await Future.delayed(const Duration(seconds: 2));
    navigatePage();
  }

  navigatePage() {
    Navigator.pushReplacementNamed(context, '/VideoPage');
  }
}
