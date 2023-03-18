import 'package:flutter/material.dart';
import '../videos/access_video_controller.dart';

ValueNotifier<List<String>> folderVideos = ValueNotifier([]);

loadVideos(String path) {
  folderVideos.value.clear();
  List<String> videoPath = [];
  List<String> splittedVideoPath = [];

  var splitted = path.split('/');

  for (var singlePath in accessVideosPath) {
    if (singlePath.startsWith(path)) {
      videoPath.add(singlePath);
    }
  }

  for (var newPath in videoPath) {
    splittedVideoPath = newPath.split('/');

    if (splittedVideoPath[splitted.length].endsWith('.mp4') ||
        splittedVideoPath[splitted.length].endsWith('.mkv')) {
      folderVideos.value.add(newPath);
    }
  }
}

ValueNotifier<List<String>> loadFolders = ValueNotifier([]);
List<String> temp = [];

Future loadFolderList() async {
  loadFolders.value.clear();
  for (String path in accessVideosPath) {
    temp.add(path.substring(0, path.lastIndexOf('/')));
  }
  loadFolders.value = temp.toSet().toList();
}
