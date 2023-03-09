import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/database/song_favorite_db.dart';
import 'package:playit/view/music/view/music_page/songs/song_list_builder.dart';
import '../../../controller/get_all_songs.dart';
import 'package:provider/provider.dart';

class SongList extends StatelessWidget {
  SongList({super.key});

  final List<SongModel> allSongs = [];

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final musicFavController = context.watch<MusicFavController>();
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
        if (!MusicFavController.isInitialized) {
          musicFavController.initialize(items.data!);
        }
        GetAllSongController.songscopy = items.data!;

        return SongListBuilder(songModel: items.data!);
      },
    );
  }
}

List<SongModel> startSong = [];
