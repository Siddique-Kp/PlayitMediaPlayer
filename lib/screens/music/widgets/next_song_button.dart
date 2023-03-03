import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';

import '../../../database/recent_song_db.dart';

class SongSkipNextButton extends StatelessWidget {
  const SongSkipNextButton({
    Key? key,
    required this.favSongModel,
    required this.iconSize,
  }) : super(key: key);

  final SongModel favSongModel;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      onPressed: () {
        if (GetAllSongController.audioPlayer.hasNext) {
          GetRecentSongController.addRecentlyPlayed(favSongModel.id);
          GetAllSongController.audioPlayer.seekToNext();
        }
      },
      icon: const Icon(
        Icons.skip_next,
        color: Colors.white,
      ),
    );
  }
}