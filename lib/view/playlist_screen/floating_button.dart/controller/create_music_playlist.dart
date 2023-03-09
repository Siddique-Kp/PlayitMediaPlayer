import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/database/song_playlist_db.dart';
import '../../../../controller/database/video_favorite_db.dart';
import '../../../../model/playit_media_model.dart';
import 'playlist_dialogue.dart';

class CreateMusicPlaylist {
  // ------- Create Music Playlist
  static createMusicPlaylis(context) {
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
}
