import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicFavController extends ChangeNotifier {
  static bool isInitialized = false;
  static final musicDb = Hive.box<int>('SongFavoriteDB');
  static List<SongModel> favoriteSongs = [];

  initialize(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isFavor(song)) {
        favoriteSongs.add(song);
      }
    }
    isInitialized = true;
  }

  isFavor(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  add(SongModel song) async {
    musicDb.add(song.id);
    favoriteSongs.add(song);
    notifyListeners();
  }

  delete(int id) async {
    int deletekey = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favorMap = musicDb.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDb.delete(deletekey);
    favoriteSongs.removeWhere((song) => song.id == id);
    notifyListeners();
  }

  clear() async {
    musicDb.clear();
    favoriteSongs.clear();
    notifyListeners();
  }
}
