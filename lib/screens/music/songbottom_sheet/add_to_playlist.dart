import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/music/music_page/songs/songs_list_page.dart';

import '../../playlist_screen/floating_button.dart/floating_button.dart';

class AddToPlaylist extends StatefulWidget {
  const AddToPlaylist({super.key});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  final floatingButton = const FloatingButton();

  @override
  Widget build(BuildContext context) {
    final musicHivebox = Hive.box<PlayItSongModel>('songplaylistDb');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to playlist'),
      ),
      body: ValueListenableBuilder(
          valueListenable: musicHivebox.listenable(),
          builder: (context, Box<PlayItSongModel> musicList, child) {
            return musicHivebox.isEmpty
                ? const Center(
                    child: Text(
                      "No Playlist Found",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.builder(
                    itemCount: musicList.length,
                    itemBuilder: (context, index) {
                      final data = musicList.values.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.library_music,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(data.name),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            songAddToPlaylist(
                                startSong[index], data, data.name);
                          },
                        ),
                      );
                    });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.playlist_add),
        onPressed: () {
          newPlayList(context, formKey, "Playlist for Music",true);
        },
      ),
    );
  }

  void songAddToPlaylist(SongModel data, PlayItSongModel playList, String name) {
    if (!playList.isValueIn(data.id)) {
      playList.add(data.id);
      snackBar(
        context: context,
        content: "Song added to $name",
        width: 2,
        inTotal: 4,
        bgcolor: const Color.fromARGB(255, 44, 43, 43),
      );
    } else {
      snackBar(
        context: context,
        content: "Song already exist in $name",
        width: 3,
        inTotal: 4,
        bgcolor: const Color.fromARGB(255, 44, 43, 43),
      );
    }
  }
}
