import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/database/recent_song_db.dart';
import 'package:playit/view/music/view/music_page/songs/song_list_builder.dart';
import 'package:provider/provider.dart';
import '../../../../../controller/database/song_favorite_db.dart';

class RecentlyPlayedWidget extends StatelessWidget {
  RecentlyPlayedWidget({Key? key}) : super(key: key);

  final OnAudioQuery _audioQuery = OnAudioQuery();
  static List<SongModel> recentSong = [];

  @override
  Widget build(BuildContext context) {
    FavoriteDb.favoriteSongs;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetRecentSongController>(context, listen: false)
          .getRecentSongs();
    });
    return Consumer<GetRecentSongController>(
      builder: (context, recentSongs, child) {
        return FutureBuilder(
          future: recentSongs.getRecentSongs(),
          builder: (context, items) {
            final value = recentSongs.recentSongNotifier;
            if (value.isEmpty) {
              return const Center(
                child: Text(
                  'No Song In Recents',
                ),
              );
            } else {
              final temp = value.reversed.toList();
              recentSong = temp.toSet().toList();
              return FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, items) {
                  if (items.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (items.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Song Available',
                      ),
                    );
                  }
                  return SongListBuilder(
                    songModel: recentSong,
                    isRecentSong: true,
                    recentLength: recentSong.length > 8 ? 8 : recentSong.length,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
