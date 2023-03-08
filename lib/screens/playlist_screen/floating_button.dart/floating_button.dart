import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playit/database/song_playlist_db.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/model/player.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:provider/provider.dart';
import '../../../core/boolians.dart';
import '../../../core/values.dart';
import '../../../database/player_db.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bodyBottomMargin),
      child: SpeedDial(
        icon: Icons.playlist_add,
        backgroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 4,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.queue_music),
              backgroundColor: const Color.fromARGB(255, 48, 47, 47),
              foregroundColor: Colors.white,
              onTap: () {
                isMusicPlaylist = true;
                newPlayList(context, formKey, "Playlist for Music",
                    isMusicPlaylist = true);
              }),
          SpeedDialChild(
              child: const Icon(Icons.playlist_play),
              backgroundColor: const Color.fromARGB(255, 48, 47, 47),
              foregroundColor: Colors.white,
              onTap: () {
                newPlayList(context, formKey, "Playlist for Video",
                    isMusicPlaylist = false);
              })
        ],
      ),
    );
  }
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController textEditingController = TextEditingController();

newPlayList(BuildContext context, GlobalKey<FormState> formKey, String text,
    bool isMusicPlaylist) {
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
                ),
              ),
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
                    if (isMusicPlaylist == true) {
                      saveMusicPlaylis(context);
                    } else {
                      saveVideoPlaylist(context);
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
    },
  );
}

Future<void> saveVideoPlaylist(context) async {
  final name = textEditingController.text.trim();
  final video = PlayerModel(name: name, videoPath: []);
  final datas = VideoPlayerListDB.videoPlayerListDB.values
      .map((e) => e.name.trim())
      .toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(video.name)) {
    snackBar(
      context: context,
      content: "Playlist already exist",
      width: 3,
      inTotal: 5,
    );
    Navigator.of(context).pop();
    textEditingController.clear();
  } else {
    VideoPlayerListDB.addPlaylist(video);
    snackBar(
      context: context,
      content: "Playlist created successfully",
      width: 3,
      inTotal: 4,
    );
    Navigator.pop(context);
    textEditingController.clear();
  }
}

Future<void> saveMusicPlaylis(context) async {
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
      inTotal: 5,
    );
    Navigator.of(context).pop();
    textEditingController.clear();
  } else {
    Provider.of<SongPlaylistDb>(context, listen: false).addPlaylist(music);
    snackBar(
      context: context,
      content: "Playlist created successfully",
      width: 3,
      inTotal: 4,
    );
    Navigator.pop(context);
    textEditingController.clear();
  }
}
