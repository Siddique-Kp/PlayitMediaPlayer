import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:playit/model/player.dart';

class VideoPlayerListDB extends ChangeNotifier {
  static List<PlayerModel> playerNotify = [];
  static final videoPlayerListDB = Hive.box<PlayerModel>('PlayerDB');

  static Future<void> addPlaylist(PlayerModel value) async {
    await videoPlayerListDB.add(value);
    playerNotify.add(value);
  }

   Future<void> getAllPlaylist() async {
    playerNotify.clear();
    playerNotify.addAll(videoPlayerListDB.values);
    notifyListeners();
  }

   Future<void> deletePlaylist(int index) async {
    await videoPlayerListDB.deleteAt(index);
    getAllPlaylist();
  }

   Future<void> editList(int index, PlayerModel value) async {
    await videoPlayerListDB.putAt(index, value);
    getAllPlaylist();
  }
}
