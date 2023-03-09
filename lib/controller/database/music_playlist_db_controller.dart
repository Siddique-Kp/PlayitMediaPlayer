import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:playit/model/playit_media_model.dart';

class MusicPlaylistDbController extends ChangeNotifier {
  final List<PlayItSongModel> _playListFolder = [];
  static final songPlaylistDb = Hive.box<PlayItSongModel>('songPlaylistDb');

  List<PlayItSongModel> get playListFolder => _playListFolder;

  Future<void> addPlaylist(PlayItSongModel value) async {
    await songPlaylistDb.add(value);
    _playListFolder.add(value);
    getAllPlaylist();
  }

  Future<void> getAllPlaylist() async {
    _playListFolder.clear();
    _playListFolder.addAll(songPlaylistDb.values);
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
