import 'package:flutter/material.dart';
import 'package:playit/controller/database/reset_app.dart';
import 'package:playit/view/settings/about_us.dart';
import 'package:playit/view/settings/privacy_policy.dart';
import 'package:playit/view/settings/terms_condition.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final Color black = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: black,
                ),
                title: const Text("About Us"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUs(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.restart_alt_outlined,
                  color: black,
                ),
                title: const Text("Reset"),
                onTap: () {
                  showdialog(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.description_outlined,
                  color: black,
                ),
                title: const Text("Terms and Conditions"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsAndCondition(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.privacy_tip_outlined,
                  color: black,
                ),
                title: const Text("Privacy policy"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.share_outlined,
                  color: black,
                ),
                title: const Text("Share App"),
                onTap: () {
                  // shareAppFile(context);
                  Share.share('https://play.google.com/store/apps/details?id=in.brototype.example.playit');
                },
              ),
            ],
          ),
          const Text(
            "Version 1.0.0",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  bottomStyle() {
    return TextButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 21, 21, 21),
    );
  }

  showdialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            const Text(
              "Are you sure you want to reset the App?\nyour saved datas will be deleted",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Reset App",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                ResetApp.resetApp(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
            InkWell(
              child: const SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
