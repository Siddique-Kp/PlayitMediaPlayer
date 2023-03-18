import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../controller/database/recent_song_db.dart';
import '../../../controller/music/get_all_songs_controller.dart';

class SongPauseButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Consumer<GetRecentSongController>(
      builder: (context, recentSong, child) {
        return GestureDetector(
          onTap: () {
            recentSong.addRecentlyPlayed(songModel.id);
            if (GetAllSongController.audioPlayer.playing) {
              GetAllSongController.audioPlayer.pause();
            } else {
              GetAllSongController.audioPlayer.play();
            }
          },
          child: StreamBuilder<bool>(
            stream: GetAllSongController.audioPlayer.playingStream,
            builder: (context, snapshot) {
              bool? playingStage = snapshot.data;
              if (playingStage != null && playingStage) {
                return iconPause;
              } else {
                return iconPlay;
              }
            },
          ),
        );
      },
    );
  }
}
