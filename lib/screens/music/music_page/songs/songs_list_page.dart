import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/song_favorite_db.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';
import '../../get_all_songs.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

List<SongModel> startSong = [];

class _SongListState extends State<SongList> {
  List<SongModel> allSongs = [];
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
          sortType: null,
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL),
      builder: (context, items) {
        if (items.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (items.data!.isEmpty) {
          return const Center(
            child: Text('No Songs found'),
          );
        }

        startSong = items.data!;
        if (!FavoriteDb.isInitialized) {
          FavoriteDb.initialize(items.data!);
        }
        GetAllSongController.songscopy = items.data!;

        return SongListBuilder(songModel: items.data!);
      },
    );
  }
}
