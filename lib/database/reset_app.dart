import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/database/song_favorite_db.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/screens/splash_screen/splash_screen.dart';

import '../model/playit_media_model.dart';

class ResetApp {
  static Future<void> resetApp(context) async {
    final songFavorite = Hive.box<int>('SongFavoriteDB');
    final videoFavorite = Hive.box<String>('VideoFavoriteDataB');
    final recentSong = Hive.box('recentSongNotifier');
    final songPlaylist = Hive.box<PlayItSongModel>('songPlaylistDb');
    final videoPlaylist = Hive.box<VideoPlaylistModel>('VideoPlaylistDb');
    final videoPlaylistItems = Hive.box<VideoPlayListItem>('VideoListItemsBox');
    final allVideoinfo = Hive.box<AllVideos>('videoplayer');
    await songFavorite.clear();
    await videoFavorite.clear();
    await recentSong.clear();
    await songPlaylist.clear();
    await videoPlaylist.clear();
    await videoPlaylistItems.clear();
    await allVideoinfo.clear();
    FavoriteDb.favoriteSongs.value.clear();
    VideoFavoriteDb.videoFavoriteDb.value.clear();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }
}
