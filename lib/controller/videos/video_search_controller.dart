import 'package:flutter/material.dart';
import 'package:playit/controller/videos/access_video_controller.dart';

import '../database/video_favorite_db.dart';

class VideoSearchController with ChangeNotifier {
  List<String> _foundVideo = [];
  List<String> _result = [];
  List<String> _allVideos = [];

  List<String> get foundVideo => _foundVideo;
  List<String> get result => _result;
  List<String> get allVideos => _allVideos;

  void setFoundVideos(result) {
    _foundVideo = result;
    notifyListeners();
  }

  void updateList(String searchText) {
    if (searchText.isEmpty) {
      _result = _allVideos;
    } else {
      _result = _allVideos
          .where((element) => element
              .split('/')
              .last
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
    setFoundVideos(_result);
    notifyListeners();
  }

  loadVideos(isFavVideo, context) {
    _allVideos =
        isFavVideo ? VideoFavoriteDb.videoDb.values.toList() : accessVideosPath;
    _foundVideo = allVideos;
  }

  onClearTextField(isFavVideo, context) {
    loadVideos(isFavVideo, context);
    notifyListeners();
  }
}
