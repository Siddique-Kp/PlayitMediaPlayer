import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../core/boolians.dart';
import '../../../core/values.dart';
import 'controller/playlist_dialogue.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bodyBottomMargin),
      child: SpeedDial(
        icon: Icons.playlist_add,
        backgroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 4,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.queue_music),
            backgroundColor: const Color.fromARGB(255, 48, 47, 47),
            foregroundColor: Colors.white,
            onTap: () {
              isMusicPlaylist = true;
              PlayListDialogue.newPlayList(context, "Playlist for Music",
                  isMusicPlaylist = true);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.playlist_play),
            backgroundColor: const Color.fromARGB(255, 48, 47, 47),
            foregroundColor: Colors.white,
            onTap: () {
              PlayListDialogue.newPlayList(context, "Playlist for Video",
                  isMusicPlaylist = false);
            },
          )
        ],
      ),
    );
  }
}








