import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:playit/model/playit_media_model.dart';

class SongPlaylistDb extends ChangeNotifier {
  static List<PlayItSongModel> playlistNotifiier = [];

  static final songPlaylistDb = Hive.box<PlayItSongModel>('songPlaylistDb');

   Future<void> addPlaylist(PlayItSongModel value) async {
    await songPlaylistDb.add(value);
    playlistNotifiier.add(value);
  }

   Future<void> getAllPlaylist() async {
    playlistNotifiier.addAll(songPlaylistDb.values);
    notifyListeners();
  }

   Future<void> deletePlaylist(int index) async {
    await songPlaylistDb.deleteAt(index);
    getAllPlaylist();
  }

   Future<void> editList(int index, PlayItSongModel value) async {
    await songPlaylistDb.putAt(index, value);
    getAllPlaylist();
  }
}
