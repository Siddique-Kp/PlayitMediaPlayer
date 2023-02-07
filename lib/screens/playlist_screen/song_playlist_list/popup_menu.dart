import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/database/song_playlist_db.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/playlist_screen/song_playlist_list/add_songs_playlist.dart';


class PlayListPopUpMusic extends StatefulWidget {
  const PlayListPopUpMusic({
    super.key,
    required this.playlist,
    required this.musicPlayitList,
    required this.index,
  });
  final PlayItSongModel playlist;
  final dynamic musicPlayitList;
  final int index;

  @override
  State<PlayListPopUpMusic> createState() => _PlayListPopUpMusicState();
}

class _PlayListPopUpMusicState extends State<PlayListPopUpMusic> {
  final TextStyle popupStyle = const TextStyle(color: Colors.white);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<int> listSongs = [];
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<PlayItSongModel>('songPlaylistDb').listenable(),
        builder: (context, Box<PlayItSongModel> songs, child) {
          listSongs = songs.values.toList()[widget.index].songId;
          return PopupMenuButton<int>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Text("Add Songs", style: popupStyle),
              ),
              PopupMenuItem(
                value: 2,
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Text("Rename", style: popupStyle),
              ),
              PopupMenuItem(
                value: 3,
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Text("Delete", style: popupStyle),
              )
            ],
            offset: const Offset(0, 50),
            color: const Color.fromARGB(255, 48, 47, 47),
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddSongsPlaylist(playlist: widget.playlist),
                    ));
              } else if (value == 2) {
                editPlaylistName(
                    context, widget.playlist, widget.index, listSongs);
              } else if (value == 3) {
                deletePlayList(context, widget.musicPlayitList, widget.index);
              }
            },
          );
        });
  }

  Future deletePlayList(
    BuildContext context,
    Box<PlayItSongModel> musicList,
    int index,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
                musicList.deleteAt(index);
                snackBar(
                    inTotal: 3,
                    width: 2,
                    context: context,
                    content: "Deleted successfully",
                    bgcolor: const Color.fromARGB(255, 48, 47, 47));
              },
            ),
            const Divider(thickness: 1),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future editPlaylistName(
      BuildContext context, PlayItSongModel data, int index, List<int> songid) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 48, 47, 47),
        children: [
          SimpleDialogOption(
            child: Text(
              "Edit Playlist '${data.name}'",
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SimpleDialogOption(
            child: Form(
                key: formKey,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: textEditingController,
                  maxLength: 15,
                  decoration: InputDecoration(
                    counterStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    fillColor: Colors.white.withOpacity(0.7),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, top: 5),
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your playlist name";
                    } else {
                      return null;
                    }
                  },
                )),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  textEditingController.clear();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final name = textEditingController.text.trim();
                    if (name.isEmpty) {
                      return;
                    } else {
                      final playlistName =
                          PlayItSongModel(name: name, songId: songid);
                      SongPlaylistDb.editList(index, playlistName);
                    }
                    textEditingController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
