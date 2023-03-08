import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/music_page/songs/mini_player_sheet.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';

class ArtistInsideList extends StatelessWidget {
  final String artistName;

  ArtistInsideList({
    super.key,
    required this.artistName,
  });

  // List<SongModel> allSongs = [];
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    String artist = artistName == "<unknown>" ? "Unknown artist" : artistName;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(artist),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL),
        builder: (context, items) {
          // allSongs.addAll(items.data!);

          if (items.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<SongModel> songByArtist =
              items.data!.where((song) => song.artist == artistName).toList();

          return SongListBuilder(songModel: songByArtist);
        },
      ),

      bottomSheet: const MiniPlayerSheet(),
    );
  }
}
