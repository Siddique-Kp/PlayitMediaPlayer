import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/recent_song_db.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';
import '../../../../database/song_favorite_db.dart';

class RecentlyPlayedWidget extends StatefulWidget {
  const RecentlyPlayedWidget({Key? key}) : super(key: key);

  @override
  State<RecentlyPlayedWidget> createState() => _RecentlyPlayedWidgetState();
}

class _RecentlyPlayedWidgetState extends State<RecentlyPlayedWidget> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  static List<SongModel> recentSong = [];

  @override
  void initState() {
    super.initState();
    recentAwait();
    setState(() {});
  }

  Future recentAwait() async {
    await GetRecentSongController.getRecentSongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FavoriteDb.favoriteSongs;
    return FutureBuilder(
      future: GetRecentSongController.getRecentSongs(),
      builder: (context, items) {
        return ValueListenableBuilder(
          valueListenable: GetRecentSongController.recentSongNotifier,
          builder:
              (BuildContext context, List<SongModel> value, Widget? child) {
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
