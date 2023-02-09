import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/database/video_playlist_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/playlist_screen/video_playlist_list/add_videos_playlist.dart';

class PlayListPopUpVideo extends StatefulWidget {
  const PlayListPopUpVideo({
    super.key,
    required this.playlist,
    required this.videoPlayitList,
    required this.index,
  });
  final VideoPlaylistModel playlist;
  final dynamic videoPlayitList;
  final int index;

  @override
  State<PlayListPopUpVideo> createState() => _PlayListPopUpVideoState();
}

class _PlayListPopUpVideoState extends State<PlayListPopUpVideo> {
  final TextStyle popupStyle = const TextStyle(color: Colors.white);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Text("Add Videos", style: popupStyle),
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
                  builder: (context) => AddVideosToPlayList(
                        playlist: widget.playlist,
                        playlistFolderIndex: widget.playlist.index,
                      )));
        } else if (value == 2) {
          editVideoPlaylistName(context, widget.playlist, widget.playlist.index!);
        } else if (value == 3) {
          deleteVideoPlayList(context, widget.videoPlayitList, widget.playlist.index!);
        }
      },
    );
  }

  Future deleteVideoPlayList(
      BuildContext context, Box<VideoPlaylistModel> videoList, int index) {
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
                videoList.deleteAt(index);
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

  Future editVideoPlaylistName(
      BuildContext context, VideoPlaylistModel data, int index) {
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
                          VideoPlaylistModel(name: name, index: index);
                      VideoPlaylistDb.editList(index, playlistName);
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
