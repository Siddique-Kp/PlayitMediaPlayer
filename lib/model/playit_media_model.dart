import 'package:hive/hive.dart';
part 'playit_media_model.g.dart';

@HiveType(typeId: 1)
class PlayItSongModel extends HiveObject {
  PlayItSongModel({required this.name, required this.songId});

  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songId;

  add(int id) async {
    songId.add(id);
    save();
  }

  deleteData(int id) {
    songId.remove(id);
    save();
  }

  clearSongs() {
    songId.clear();
    save();
  }

  bool isValueIn(int id) {
    return songId.contains(id);
  }
}

@HiveType(typeId: 2)
class VideoFavourite extends HiveObject {
  VideoFavourite(
      {required this.title,
      this.index,
      required this.videoPath,
      required this.duration});

  @HiveField(0)
  dynamic index;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String videoPath;

  @HiveField(3)
  final String duration;
}

@HiveType(typeId: 3)
class VideoFavoriteModel {
  VideoFavoriteModel(
      {required this.title, required this.videoPath, required this.videoSize});

  @HiveField(0)
  String title;

  @HiveField(1)
  String videoPath;

  @HiveField(2)
  String videoSize;
}

@HiveType(typeId: 4)
class VideoPlaylistModel {
  VideoPlaylistModel({required this.name, this.index});

  @HiveField(0)
  String name;

  @HiveField(1)
  int? index;
}

@HiveType(typeId: 5)
class AllVideos {
  @HiveField(0)
  final String duration;
  @HiveField(1)
  final String path;
  AllVideos({required this.duration, required this.path});
}

@HiveType(typeId: 6)
class VideoPlayListItem extends HiveObject {
  VideoPlayListItem(
      {required this.videoPath,
      required this.playlistFolderindex,
      required this.duration});

  @HiveField(0)
  String videoPath;
  @HiveField(1)
  int playlistFolderindex;
  @HiveField(2)
  String duration;
}
