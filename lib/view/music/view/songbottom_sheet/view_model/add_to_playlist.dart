import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/database/video_favorite_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/view/music/view/music_page/songs/songs_list_page.dart';
import '../../../../playlist_screen/floating_button.dart/controller/playlist_dialogue.dart';
import '../../../../playlist_screen/floating_button.dart/floating_button.dart';

class AddToPlaylist extends StatelessWidget {
  const AddToPlaylist({super.key, required this.index});
  final int index;

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
                            startSong[index],
                            data,
                            data.name,
                            context,
                          );
                        },
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.playlist_add),
        onPressed: () {
          PlayListDialogue.newPlayList(context, "Playlist for Music", true);
        },
      ),
    );
  }

  void songAddToPlaylist(
    SongModel data,
    PlayItSongModel playList,
    String name,
    context,
  ) {
    if (!playList.isValueIn(data.id)) {
      playList.add(data.id);
      snackBar(
        context: context,
        content: "Song added to $name",
        width: 3,
        inTotal: 4,
      );
    } else {
      snackBar(
        context: context,
        content: "Song already exist in $name",
        width: 3,
        inTotal: 4,
      );
    }
  }
}
