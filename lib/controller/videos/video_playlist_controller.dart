import 'package:flutter/material.dart';

import '../../model/player.dart';
import '../database/video_favorite_db.dart';

class VideoPlaylistController with ChangeNotifier {
  addVideosToPlaylist(
      {required PlayerModel videoModel,
      required String path,
      required context}) {
    videoModel.add(path);
    notifyListeners();
    snackBar(
      inTotal: 2,
      width: 1,
      context: context,
      content: "Song Added",
    );
  }

  removeVideosFromPlaylist({
    required PlayerModel videoModel,
    required String path,
  }) {
    videoModel.deleteData(path);
    notifyListeners();
  }
}
