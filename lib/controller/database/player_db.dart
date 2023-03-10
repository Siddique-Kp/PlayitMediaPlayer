import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:playit/model/player.dart';

class VideoPlayerListDB extends ChangeNotifier {
  static ValueNotifier<List<PlayerModel>> playerNotify =
      ValueNotifier([]);
  static final videoPlayerListDB = Hive.box<PlayerModel>('PlayerDB');

  static Future<void> addPlaylist(PlayerModel value) async {
    await videoPlayerListDB.add(value);
    playerNotify.value.add(value);
  }

  static Future<void> getAllPlaylist() async {
    playerNotify.value.clear();
    playerNotify.value.addAll(videoPlayerListDB.values);
    playerNotify.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    await videoPlayerListDB.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editList(int index, PlayerModel value) async {
    await videoPlayerListDB.putAt(index, value);
    getAllPlaylist();
  } 
}
