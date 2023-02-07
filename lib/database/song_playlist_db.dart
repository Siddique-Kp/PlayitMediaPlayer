import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:playit/model/playit_media_model.dart';

class SongPlaylistDb extends ChangeNotifier{
  static ValueNotifier<List<PlayItSongModel>> playlistNotifiier =
      ValueNotifier([]);
  static final songPlaylistDb = Hive.box<PlayItSongModel>('songPlaylistDb');

  static Future<void> addPlaylist(PlayItSongModel value) async {
    final songPlaylistDb = Hive.box<PlayItSongModel>('songPlaylistDb');
    await songPlaylistDb.add(value);
    playlistNotifiier.value.add(value);
  }

  static Future<void> getAllPlaylist() async {
    final songPlaylistDb = Hive.box<PlayItSongModel>('songPlaylistDb');
    playlistNotifiier.value.clear();
    playlistNotifiier.value.addAll(songPlaylistDb.values);
    playlistNotifiier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final songPlaylistDb = Hive.box<PlayItSongModel>('songPlaylistDb');
    await songPlaylistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editList(int index, PlayItSongModel value) async {
    final songPlaylistDb = Hive.box<PlayItSongModel>('songPlaylistDb');
    await songPlaylistDb.putAt(index, value);
    getAllPlaylist();
  }
}
