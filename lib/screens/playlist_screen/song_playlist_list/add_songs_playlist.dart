import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/provider/song_playlist/song_playlist.dart';
import 'package:playit/screens/music/widgets/art_work.dart';
import 'package:provider/provider.dart';

class AddSongsPlaylist extends StatelessWidget {
  AddSongsPlaylist({super.key, required this.playlist});
  final PlayItSongModel playlist;

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Songs to playlist"),
        centerTitle: true,
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
          if (items.data!.isEmpty) {
            return const Center(
              child: Text('No Songs found'),
            );
          }
          return ListView.builder(
            itemExtent: 80,
            itemBuilder: (context, index) {
              final String songTitle = items.data![index].displayNameWOExt;
              String artistName = items.data![index].artist!;

              return Consumer<SongPlylistProvider>(
                builder: (context, songPlaylistProvider, child) {
                  return ListTile(
                    leading: ArtWorkWidget(
                      songModel: items.data![index],
                      size: 60,
                    ),
                    title: Text(
                      songTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      artistName == '<unknown>' ? "Unknown artist" : artistName,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        bool isValueIn =
                            playlist.isValueIn(items.data![index].id);
                        if (!isValueIn) {
                          songPlaylistProvider.addSongsToPlaylist(
                              songModel: playlist,
                              data: items.data![index],
                              context: context);
                        } else {
                          songPlaylistProvider.removeSongsFromPlaylist(
                            songModel: playlist,
                            data: items.data![index],
                          );
                        }
                      },
                      icon: !playlist.isValueIn(items.data![index].id)
                          ? const Icon(Icons.add)
                          : const Icon(Icons.remove),
                    ),
                  );
                },
              );
            },
            itemCount: items.data!.length,
          );
        },
      ),
    );
  }
}
