import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';

class ArtistInsideList extends StatefulWidget {
  final String artistName;

  const ArtistInsideList({
    super.key,
    required this.artistName,
  });

  @override
  State<ArtistInsideList> createState() => _ArtistInsideListState();
}

class _ArtistInsideListState extends State<ArtistInsideList> {
  // List<SongModel> allSongs = [];
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    String artist =
        widget.artistName == "<unknown>" ? "Unknown artist" : widget.artistName;
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

              String artistName = widget.artistName;
              List<SongModel> songByArtist = items.data!
                  .where((song) => song.artist == artistName)
                  .toList();

              return SongListBuilder(songModel: songByArtist);
            }));
  }
}
