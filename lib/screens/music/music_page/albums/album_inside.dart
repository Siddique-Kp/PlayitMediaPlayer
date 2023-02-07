import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';

class AlbumsInsideList extends StatefulWidget {
  final String albumName;

  const AlbumsInsideList({
    super.key,
    required this.albumName,
  });

  @override
  State<AlbumsInsideList> createState() => _AlbumsInsideListState();
}

class _AlbumsInsideListState extends State<AlbumsInsideList> {
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(widget.albumName),
        ),
        body: FutureBuilder<List<SongModel>>(
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

              String albumName = widget.albumName;
              List<SongModel> songByAlbum =
                  items.data!.where((song) => song.album == albumName).toList();

              return SongListBuilder(songModel: songByAlbum);
            }));
  }
}
