import 'package:flutter/material.dart';
import '../../../../model/database/player_db.dart';
import '../../../../model/database/video_favorite_db.dart';
import '../../../../model/player.dart';
import 'playlist_dialogue.dart';

class CreateVideoPlaylist {
  // ----- create new video playlist
  static createVideoPlaylist(context) {
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
}
