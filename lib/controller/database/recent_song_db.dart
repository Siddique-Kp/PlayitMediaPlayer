import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/view/music/view/music_page/songs/songs_list_page.dart';


class GetRecentSongController extends ChangeNotifier{
 List<SongModel> recentSongNotifier = [];
  static List<dynamic> recentlyPlayed = [];
  static final recentDb =  Hive.box('recentSongNotifier');

   Future<void> addRecentlyPlayed(item) async {
    await recentDb.add(item);
    getRecentSongs();
    notifyListeners();
  }

   Future<void> getRecentSongs() async {
    recentlyPlayed = recentDb.values.toList();
    displayRecents();
    notifyListeners();
  }

   Future<void> displayRecents() async {
    final recentSongItems = recentDb.values.toList();
    recentSongNotifier.clear();
    recentlyPlayed.clear();
    for (int i = 0; i < recentSongItems.length; i++) {
      for (int j = 0; j < startSong.length; j++) {
        if (recentSongItems[i] == startSong[j].id) {
          recentSongNotifier.add(startSong[j]);
          recentlyPlayed.add(startSong[j]);
        }
      }
    }
  }
}
