import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/main.dart';
import 'package:playit/model/playit_media_model.dart';

import 'folder_videos/accsess_folder.dart';

class AccessFilesFromStorage {
  static const channel = MethodChannel("fetch_files_from_storage");

  static void accessFromStorage(List<String> query,
      void Function(List<String>) onSuccess, void Function(String) onError) {
    channel.invokeMethod('search', query).then((value) {
      final res = value as List<Object?>;
      onSuccess(res.map((e) => e.toString()).toList());
    }).onError((error, stackTrace) {
      log(error.toString());
      onError(error.toString());
    });
  }
}

List<String> accessVideosPath = [];

Future<bool> requestPermission(Permission permission) async {
  const storage = Permission.storage;
  const mediaAccess = Permission.accessMediaLocation;
  if (await permission.isGranted) {
    await mediaAccess.isGranted && await storage.isGranted;
    return true;
  } else {
    var result = await storage.request();
    var mediaresult = await mediaAccess.request();

    if (result == PermissionStatus.granted &&
        mediaresult == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future videoFetch() async {
  if (await requestPermission(Permission.storage)) {
    AccessFilesFromStorage.accessFromStorage([
      '.mkv',
      '.mp4',
    ], onSuccess, (p0) {});
  } else {
    videoFetch();
  }
}

onSuccess(List<String> path) {
  accessVideosPath = path;
  for (var i = 0; i < accessVideosPath.length; i++) {
    if (accessVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
      accessVideosPath.remove(accessVideosPath[i]);
      i--;
    }
  }
  loadFolderList();
  loadVideoduration();
}

ValueNotifier<List<String>> allVideos = ValueNotifier([]);
List<AllVideos> aLLvideoList = [];




final videoInfo = FlutterVideoInfo();
Future loadVideoduration() async {
  if (videoDB.isEmpty || videoDB.length != accessVideosPath.length) {
    videoDB.clear();
    AllVideos videosObj;
    for (var i = 0; i < accessVideosPath.length; i++) {
      
      VideoData? info = await videoInfo.getVideoInfo(accessVideosPath[i]);
      double? second = info!.duration! / 1000;
      String? duration = convertSecond(second);

      videosObj = AllVideos(duration: duration,path: info.path!);
      videoDB.add(videosObj);
    }
  }
  allVideos.value.clear();
  allVideos.value = accessVideosPath.toList();
}

String convertSecond(durinsec) {
  double hours = durinsec / 3600;
  String minute = hours.toString().split(".").last;
  String hh = hours.toString().split(".").first;
  String mmmm = "0.$minute";
  double num = double.parse(mmmm);
  double mmm = (num) * 60;
  String mm = mmm.toString().split(".").first;
  mm.length == 1 ? mm = "0$mm" : mm = mm;
  hh.length == 1 ? hh = "0$hh" : hh = hh;
  String ssss = mmm.toString().split(".").last;
  String sss = "0.$ssss";
  double number = double.parse(sss);
  double ss = number * 60;
  int sec = ss.round();
  String second = sec.toString();
  second.length == 1 ? second = "0$second" : second = second;
  String hhmmss;

  hhmmss = "$hh:$mm:$second";
  return hhmmss;
}
