import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/music_page/albums/album_inside.dart';

class SongAlbumsPage extends StatelessWidget {
  SongAlbumsPage({super.key});

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
        future: _audioQuery.queryAlbums(
            sortType: AlbumSortType.ALBUM,
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL),
        builder: (context, items) {
          final albumList = items.data;
          if (items.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (items.data!.isEmpty) {
            return const Center(
              child: Text('No Album found'),
            );
          }

          return ListView.builder(
            itemExtent: 80,
            itemCount: albumList!.length,
            itemBuilder: (context, index) {
              final albumName = albumList[index].album;
              return Center(
                child: ListTile(
                  leading: QueryArtworkWidget(
                    id: albumList[index].id,
                    type: ArtworkType.ALBUM,
                    artworkBorder: BorderRadius.circular(3),
                    artworkHeight: 60,
                    artworkWidth: 60,
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3)),
                      width: 60,
                      height: 60,
                      child: const Center(
                          child: Icon(
                        Icons.my_library_music_outlined,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  title: Text(
                    albumName,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 17,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AlbumsInsideList(albumName: albumName),
                        ));
                  },
                ),
              );
            },
          );
        });
  }
}
