import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/song_playlist_db.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/model/playit_media_model.dart';

class AddSongsPlaylist extends StatefulWidget {
  const AddSongsPlaylist({super.key, required this.playlist});
  final PlayItSongModel playlist;

  @override
  State<AddSongsPlaylist> createState() => _AddSongsPlaylistState();
}

class _AddSongsPlaylistState extends State<AddSongsPlaylist> {
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

                return ListTile(
                  leading: QueryArtworkWidget(
                    id: items.data![index].id,
                    type: ArtworkType.AUDIO,
                    keepOldArtwork: true,
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
                        Icons.music_note,
                        color: Colors.white,
                      )),
                    ),
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
                  trailing: !widget.playlist.isValueIn(items.data![index].id)
                      ? addSongInPlaylist(items.data![index])
                      : removeSongsPlaylist(items.data!, index),
                );
              },
              itemCount: items.data!.length,
            );
          },
        ));
  }

  Widget addSongInPlaylist(SongModel data) {
    return IconButton(
        onPressed: () {
          setState(() {
            widget.playlist.add(data.id);
            SongPlaylistDb.playlistNotifiier.notifyListeners();
          });
          snackBar(
             inTotal: 2,
             width: 1,
              context: context,
              content: "Song Added",
              );
        },
        icon: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 10,
          child: Icon(
            Icons.add,
            size: 20,
          ),
        ));
  }

  Widget removeSongsPlaylist(List<SongModel> data, int index) {
    return IconButton(
        onPressed: () {
          setState(() {
            widget.playlist.deleteData(data[index].id);
          });
         snackBar(
          inTotal: 2,
             width: 1,
              context: context,
              content: "Song Deleted",
              );
        },
        icon: const CircleAvatar(
          radius: 10,
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.horizontal_rule,
            size: 16,
            color: Colors.white,
          ),
        ));
  }
}
