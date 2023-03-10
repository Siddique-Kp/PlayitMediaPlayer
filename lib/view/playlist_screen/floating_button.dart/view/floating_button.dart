import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playit/core/colors.dart';
import '../../../../core/boolians.dart';
import '../controller/playlist_dialogue.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.playlist_add,
      backgroundColor: kBlackColor,
      overlayColor: kBlackColor,
      overlayOpacity: 0.4,
      spacing: 12,
      spaceBetweenChildren: 4,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.queue_music),
          backgroundColor: kSpeedButtonColor,
          foregroundColor: kWhiteColor,
          onTap: () {
            isMusicPlaylist = true;
            PlayListDialogue.newPlayList(
              context,
              "Playlist for Music",
              isMusicPlaylist = true,
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.playlist_play),
          backgroundColor: kSpeedButtonColor,
          foregroundColor: kWhiteColor,
          onTap: () {
            PlayListDialogue.newPlayList(
              context,
              "Playlist for Video",
              isMusicPlaylist = false,
            );
          },
        )
      ],
    );
  }
}
