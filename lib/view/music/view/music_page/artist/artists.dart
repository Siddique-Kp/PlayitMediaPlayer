import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/view/music/view/music_page/artist/artist_inside.dart';

class SongArtisPage extends StatelessWidget {
  SongArtisPage({super.key});

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArtistModel>>(
        future: _audioQuery.queryArtists(
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
              child: Text('No Arist found'),
            );
          }

          return ListView.builder(
            itemExtent: 80,
            itemCount: items.data!.length,
            itemBuilder: (context, index) {
              final artistName = items.data![index].artist;
               String artist = artistName == "<unknown>" ? "Unknown artist":artistName;
              return Center(
                child: ListTile(
                  leading: QueryArtworkWidget(
                    id: items.data![index].id,
                    type: ArtworkType.ARTIST,
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
                        Icons.person,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  title: Text(
                    artist,
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
                              ArtistInsideList(artistName: artistName),
                        ));
                  },
                ),
              );
            },
          );
        });
  }
}
