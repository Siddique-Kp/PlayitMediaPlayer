import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/playit_media_model.dart';

class VideoFavoriteDb extends ChangeNotifier {
  static bool isInitialized = false;
  static final videoDb = Hive.box<String>('VideoFavoriteDataB');
  static ValueNotifier<List<VideoFavoriteModel>> videoFavoriteDb =
      ValueNotifier([]);

  static void initialize(VideoFavoriteModel value) {
    if (isVideoFavor(value)) {
      videoFavoriteDb.value.add(value);
      videoFavoriteDb.notifyListeners();
    }
    isInitialized = true;
  }

  static isVideoFavor(VideoFavoriteModel videoFav) {
    if (videoDb.values.contains(videoFav.videoPath)) {
      return true;
    } else {
      return false;
    }
  }

  static videoAdd(VideoFavoriteModel value, context) {
    videoDb.add(value.videoPath);
    videoFavoriteDb.value.add(value);
    videoFavoriteDb.notifyListeners();
    snackBar(
        context: context,
        content: "video added to favorite",
        width: 3,
        inTotal: 4,
        bgcolor: const Color.fromARGB(255, 66, 64, 64));
  }

  static videoDelete(String videoPath, context) {
    
    int deleteKey = 0;
    if (!videoDb.values.contains(videoPath)) {
      return;
    }
    final Map<dynamic, String> videoFavMap = videoDb.toMap();
    videoFavMap.forEach((key, value) {
      if (value == videoPath) {
        deleteKey = key;
      }
    });
    videoDb.delete(deleteKey);
    videoFavoriteDb.value.removeWhere((element) => element.videoPath == videoPath );
    videoFavoriteDb.notifyListeners();
    snackBar(
        context: context,
        content: "Removed from favorite",
        width: 2,
        inTotal: 4,
        bgcolor:const Color.fromARGB(255, 66, 64, 64));
  }
}

Future<void> snackBar(
    {required BuildContext context,
    required content,
    required int width,
    required int inTotal,
    required bgcolor,
    function}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: MediaQuery.of(context).size.width * width / inTotal,
      duration: const Duration(seconds: 1),
      content: SizedBox(
        height: 17,
        child: Center(
            child: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
          ),
        )),
      ),
      backgroundColor: bgcolor,
      behavior: SnackBarBehavior.floating,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
