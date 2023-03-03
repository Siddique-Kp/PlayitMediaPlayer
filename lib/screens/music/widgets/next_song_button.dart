import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';
import 'package:provider/provider.dart';

import '../../../database/recent_song_db.dart';

class SongSkipNextButton extends StatefulWidget {
  const SongSkipNextButton({
    Key? key,
    required this.favSongModel,
    required this.iconSize,
  }) : super(key: key);

  final SongModel favSongModel;
  final double iconSize;

  @override
  State<SongSkipNextButton> createState() => _SongSkipNextButtonState();
}

class _SongSkipNextButtonState extends State<SongSkipNextButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRecentSongController>(
      builder: (context, recentSong, child) {
        return IconButton(
          iconSize: widget.iconSize,
          onPressed: () async {
            if (GetAllSongController.audioPlayer.hasNext ) {
              await recentSong.addRecentlyPlayed(
                  widget.favSongModel.id);
              await GetAllSongController.audioPlayer.seekToNext();
              setState(() {
                selectedIndex = widget.favSongModel.id;
              });
            }
          },
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
          ),
        );
      }
    );
  }
}
