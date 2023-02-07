import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:playit/model/playit_media_model.dart';

class VideoPlaylistDb extends ChangeNotifier {
  static ValueNotifier<List<VideoPlaylistModel>> videoplaylistnotifier =
      ValueNotifier([]);
  static ValueNotifier<List<VideoPlayListItem>> playlistitemsNotifier =
      ValueNotifier([]);

  static final videoPlaylistdb =
      Hive.box<VideoPlaylistModel>('VideoPlaylistDb');

  static addVideoPlaylist(VideoPlaylistModel value) async {
    final videoPlaylistdb =
        await Hive.openBox<VideoPlaylistModel>('VideoPlaylistDb');
    final id = await videoPlaylistdb.add(value);
    value.index = id;
    videoplaylistnotifier.value.add(value);
    videoplaylistnotifier.notifyListeners();
  }

  static getAllPlaylist() async {
    final videoPlaylistdb = Hive.box<VideoPlaylistModel>('videoPlaylistdb');
    videoplaylistnotifier.value.clear();
    videoplaylistnotifier.value.addAll(videoPlaylistdb.values);
    videoplaylistnotifier.notifyListeners();
  }

  static deleteVideoPlaylist(int index) async {
    final videoPlaylistdb = Hive.box<VideoPlaylistModel>('VideoPlaylistDb');
    await videoPlaylistdb.deleteAt(index);
    getAllPlaylist();
  }

  static editList(int index, VideoPlaylistModel value) async {
    final videoPlaylistdb = Hive.box<VideoPlaylistModel>('VideoPlaylistDb');
    await videoPlaylistdb.putAt(index, value);
    getAllPlaylist();
  }

  static videoListItemadd(VideoPlayListItem value) async {
    final listitemshive = Hive.box<VideoPlayListItem>('VideoListItemsBox');
    await listitemshive.add(value);
    playlistitemsNotifier.value.add(value);
    playlistitemsNotifier.notifyListeners();
  }

  static Future<void> getPlayListitems() async {
    final listitemshive = Hive.box<VideoPlayListItem>('VideoListItemsBox');
    playlistitemsNotifier.value.clear();
    playlistitemsNotifier.value.addAll(listitemshive.values);
    playlistitemsNotifier.notifyListeners();
  }

  static Future<void> deleteListItem(
      {required int index, required context}) async {
    final listitemshive = Hive.box<VideoPlayListItem>('VideoListItemsBox');
    await listitemshive.deleteAt(index);
    await getPlayListitems();
  }
}
