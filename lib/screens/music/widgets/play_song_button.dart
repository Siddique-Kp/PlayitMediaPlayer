import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../database/recent_song_db.dart';
import '../get_all_songs.dart';
import '../music_page/songs/now_playint_bottom_sheet.dart';

class SongPauseButton extends StatefulWidget {
  const SongPauseButton({
    super.key,
    required this.songModel,
    required this.iconPlay,
    required this.iconPause,
  });
  final SongModel songModel;
  final Widget iconPlay;
  final Widget iconPause;

  @override
  State<SongPauseButton> createState() => _SongPauseButtonState();
}

class _SongPauseButtonState extends State<SongPauseButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRecentSongController>(
      builder: (context, recentSong, child){
        return GestureDetector(
          onTap: () {
            setState(() {
               recentSong.addRecentlyPlayed(widget.songModel.id);
              if (GetAllSongController.audioPlayer.playing) {
                GetAllSongController.audioPlayer.pause();
              } else {
                GetAllSongController.audioPlayer.play();
              }
              isPlaying = !isPlaying;
            });
          },
          child: StreamBuilder<bool>(
            stream: GetAllSongController.audioPlayer.playingStream,
            builder: (context, snapshot) {
              bool? playingStage = snapshot.data;
              if (playingStage != null && playingStage) {
                return widget.iconPause;
              } else {
                return widget.iconPlay;
              }
            },
          ),
        );
      }
    );
  }
}
