import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  final Color black = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
        ),
        body: Column(
          
          children: [
            ListTile(
             
              leading: Icon(Icons.info_outline,color:black,),
              title: const Text("About Us"),
              onTap: () {},
            ),
            ListTile(
              leading:  Icon(Icons.description_outlined,color: black,),
              title: const Text("Terms and Conditions"),
              onTap: () {},
            ),
            ListTile(
              leading:  Icon(Icons.privacy_tip_outlined,color: black,),
              title: const Text("Privacy policy"),
              onTap: () {},
            ),
            ListTile(
              leading:  Icon(Icons.share_outlined,color: black,),
              title: const Text("Share App"),
              onTap: () {},
            ),
            ListTile(
              leading:  Icon(Icons.restart_alt_outlined,color: black,),
              title: const Text("Reset"),
              onTap: () {},
            ),
          ],
        ));
  }
}
