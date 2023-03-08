import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../database/recent_song_db.dart';
import '../../../provider/music_buttons/music_buttond_provider.dart';
import '../get_all_songs.dart';

class SongSkipPreviousButton extends StatelessWidget {
  const SongSkipPreviousButton({
    super.key,
    required this.songModel,
  });

  final SongModel songModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetRecentSongController>(
      builder: (context, recentSong, child) {
        return IconButton(
          iconSize: 40,
          onPressed: () {
            if (GetAllSongController.audioPlayer.hasPrevious) {
              recentSong.addRecentlyPlayed(songModel.id);
              GetAllSongController.audioPlayer.seekToPrevious();
              context
                  .read<MusicButtonsProvider>()
                  .selectedListTile(songModel.id);
            }
          },
          icon: const Icon(
            Icons.skip_previous,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
