import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("About Us"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/launch_image.svg',
                  width: MediaQuery.of(context).size.width * 2 / 10,
                ),
                const Text(
                  'Version 1.0.0',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  '''Welcome to PLAYiT media player Application,\n  You can enjoy Ad free videos and musics
that fetched from your device''',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const Text(
              '''Released on feb 2023\n Developed by Aboobacker Siddique KP''',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
