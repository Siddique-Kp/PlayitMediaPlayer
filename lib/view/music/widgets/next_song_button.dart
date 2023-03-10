import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/view/music/controller/get_all_songs.dart';
import 'package:provider/provider.dart';
import '../../../controller/database/recent_song_db.dart';
import '../../../controller/music/music_tile_controller.dart';

class SongSkipNextButton extends StatelessWidget {
  const SongSkipNextButton({
    Key? key,
    required this.songModel,
    required this.iconSize,
  }) : super(key: key);

  final SongModel songModel;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetRecentSongController>(
      builder: (ctx, recentSong, child) {
        return IconButton(
          iconSize: iconSize,
          onPressed: () {
            if (GetAllSongController.audioPlayer.hasNext) {
              recentSong.addRecentlyPlayed(songModel.id);
              GetAllSongController.audioPlayer.seekToNext();
              context
                  .read<MusicTileController>()
                  .selectedMusicTile(playingSongid: songModel.id);
            }
          },
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
