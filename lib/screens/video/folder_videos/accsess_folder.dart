import 'package:flutter/material.dart';
 import '../access_video.dart';

ValueNotifier<List<String>> folderVideos = ValueNotifier([]);

loadVideos(String path) {
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

List<String> loadFolders = [];
List<String> temp = [];

Future loadFolderList() async {
  for (String path in accessVideosPath) {
    temp.add(path.substring(0, path.lastIndexOf('/')));
  }
  loadFolders = temp.toSet().toList();
}