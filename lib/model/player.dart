import 'package:hive_flutter/hive_flutter.dart';
part 'player.g.dart';

@HiveType(typeId: 7)
class PlayerModel extends HiveObject {
  PlayerModel({required this.name, required this.videoPath});

  @HiveField(0)
  String name;
  @HiveField(1)
  List<String> videoPath;

  add(String path) async {
    videoPath.add(path);
    save();
  }

  deleteData(String path) {
    videoPath.remove(path);
    save();
  }

  clearSongs() {
    videoPath.clear();
    save();
  }

  bool isValueIn(String path) {
    return videoPath.contains(path);
  }
}
