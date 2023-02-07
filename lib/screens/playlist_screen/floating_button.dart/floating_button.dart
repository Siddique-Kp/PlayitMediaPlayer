import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playit/database/song_playlist_db.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/database/video_playlist_db.dart';
import 'package:playit/model/playit_media_model.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController textEditingController = TextEditingController();

class _FloatingButtonState extends State<FloatingButton> {
  bool playlistFor = true;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.playlist_add,
      backgroundColor: Colors.black,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      spacing: 12,
      spaceBetweenChildren: 4,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.queue_music),
            label: 'SongPlaylist',
            labelStyle: const TextStyle(color: Colors.white),
            labelBackgroundColor: const Color.fromARGB(255, 48, 47, 47),
            backgroundColor: const Color.fromARGB(255, 48, 47, 47),
            foregroundColor: Colors.white,
            onTap: () {
              playlistFor = true;
              newPlayList(
                  context, formKey, "Playlist for Music", playlistFor = true);
            }),
        SpeedDialChild(
            child: const Icon(Icons.playlist_play),
            label: 'VideoPlaylist',
            labelBackgroundColor: const Color.fromARGB(255, 48, 47, 47),
            labelStyle: const TextStyle(color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 48, 47, 47),
            foregroundColor: Colors.white,
            onTap: () {
              newPlayList(
                  context, formKey, "Playlist for Video", playlistFor = false);
            })
      ],
    );
  }
}

Future newPlayList(BuildContext context, GlobalKey<FormState> formKey,
    String text, bool playListFor) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 48, 47, 47),
          children: [
            SimpleDialogOption(
              child: Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: SimpleDialogOption(
                child: Form(
                    key: formKey,
                    child: TextFormField(
                      textAlign: TextAlign.left,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
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
                      if (playListFor == true) {
                        saveButtonPressedMusic(context);
                      } else {
                        saveButtonVideoPlaylist(context);
                      }
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        );
      });
}

Future<void> saveButtonVideoPlaylist(context) async {
  final name = textEditingController.text.trim();
  final video = VideoPlaylistModel(name: name);
  final datas =
      VideoPlaylistDb.videoPlaylistdb.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(video.name)) {
    snackBar(
      context: context,
      content: "Playlist already exist",
      width: 3,
      inTotal: 4,
      bgcolor: const Color.fromARGB(255, 48, 47, 47),
    );
    Navigator.of(context).pop();
  } else {
    VideoPlaylistDb.addVideoPlaylist(video);
    snackBar(
      context: context,
      content: "Playlist created successfully",
      width: 3,
      inTotal: 4,
      bgcolor: const Color.fromARGB(255, 48, 47, 47),
    );
    Navigator.pop(context);
    textEditingController.clear();
  }
}

Future<void> saveButtonPressedMusic(context) async {
  final name = textEditingController.text.trim();
  final music = PlayItSongModel(name: name, songId: []);
  final datas =
      SongPlaylistDb.songPlaylistDb.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(music.name)) {
    snackBar(
      context: context,
      content: "Playlist already exist",
      width: 3,
      inTotal: 4,
      bgcolor: const Color.fromARGB(255, 48, 47, 47),
    );
    Navigator.of(context).pop();
  } else {
    SongPlaylistDb.addPlaylist(music);
    snackBar(
      context: context,
      content: "Playlist created successfully",
      width: 3,
      inTotal: 4,
      bgcolor: const Color.fromARGB(255, 48, 47, 47),
    );
    Navigator.pop(context);
    textEditingController.clear();
  }
}
