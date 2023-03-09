import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/database/song_favorite_db.dart';
import 'package:playit/model/database/video_favorite_db.dart';
import 'package:playit/model/player.dart';
import 'package:playit/view/music/controller/get_all_songs.dart';
import 'package:playit/view/splash_screen/splash_screen.dart';
import '../../core/boolians.dart';
import '../../core/values.dart';
import '../playit_media_model.dart';

class ResetApp {
  static Future<void> resetApp(context) async {
    final songFavorite = Hive.box<int>('SongFavoriteDB');
    final videoFavorite = Hive.box<String>('VideoFavoriteDataB');
    final recentSong = Hive.box('recentSongNotifier');
    final songPlaylist = Hive.box<PlayItSongModel>('songPlaylistDb');
    final videoPlaylist = Hive.box<VideoPlaylistModel>('VideoPlaylistDb');
    final videoPlaylistItems = Hive.box<VideoPlayListItem>('VideoListItemsBox');
    final allVideoinfo = Hive.box<AllVideos>('videoplayer');
    final allVideoPlaylist = Hive.box<PlayerModel>('PlayerDB');
    await songFavorite.clear();
    await videoFavorite.clear();
    await recentSong.clear();
    await songPlaylist.clear();
    await videoPlaylist.clear();
    await videoPlaylistItems.clear();
    await allVideoinfo.clear();
    await allVideoPlaylist.clear();
    FavoriteDb.favoriteSongs.value.clear();
    VideoFavoriteDb.videoFavoriteDb.value.clear();
    GetAllSongController.audioPlayer.pause();
    isPlayingSong = false;
    selectedIndex = 0;
    bodyBottomMargin = 0;

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }
}
