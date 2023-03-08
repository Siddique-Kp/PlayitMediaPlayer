import 'package:flutter/material.dart';
import 'package:playit/screens/music/music_page/songs/mini_player_sheet.dart';
import 'package:playit/screens/playlist_screen/play_list_page.dart';
import 'package:playit/screens/video/videopage.dart';
import '../../core/values.dart';
import '../music/music_page.dart';
import '../settings/settings_page.dart';

class BottomNavBarScreen extends StatelessWidget {
  BottomNavBarScreen({super.key});

  final ValueNotifier<int> pageindex = ValueNotifier(0);
  static const List<Widget> pages = [
    VideoPage(),
    MusicPage(),
    PlayList(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: pageindex,
          builder: (context, pageIndex, child) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: bodyBottomMargin,
              ),
              child: IndexedStack(
                index: pageIndex,
                children: pages,
              ),
            );
          },
        ),
        bottomSheet: ValueListenableBuilder(
            valueListenable: pageindex,
            builder: (context, value, child) {
              return pageindex.value != 3
                  ? const MiniPlayerSheet()
                  : const SizedBox();
            }),

        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: pageindex,
          builder: (context, pageIndex, child) {
            return NavigationBar(
              selectedIndex: pageIndex,
              backgroundColor: Colors.white,
              onDestinationSelected: (value) {
                pageindex.value = value;
                
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.play_circle),
                  label: 'Video',
                ),
                NavigationDestination(
                  icon: Icon(Icons.headphones),
                  label: 'Music',
                ),
                NavigationDestination(
                  icon: Icon(Icons.queue_music),
                  label: 'Playlist',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            );
          },
        ),

        // bottomNavigationBar:
        // BottomNavigationBar(
        //     onTap: (index) => changePage(index),
        //     selectedItemColor: Colors.blue,
        //     unselectedItemColor: Colors.grey,
        //     showUnselectedLabels: true,
        //     currentIndex: pageindex,
        //     selectedFontSize: 12,
        //     items: const [
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.play_arrow), label: 'Video'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.music_note), label: 'Music'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.playlist_add), label: 'Playlist'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.settings), label: 'Settings'),
        //     ]),
      ),
    );
  }
}
