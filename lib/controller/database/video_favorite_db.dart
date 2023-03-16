import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/main.dart';
import 'package:playit/model/playit_media_model.dart';

class VideoFavoriteDb with ChangeNotifier {
  static bool isInitialized = false;
  static final videoDb = Hive.box<String>('VideoFavoriteDataB');
  static List<VideoFavoriteModel> videoFavoriteDb = [];

  void initialize(VideoFavoriteModel value) {
    if (isVideoFavor(value)) {
      videoFavoriteDb.add(value);
    }
    isInitialized = true;
    notifyListeners();
  }

   isVideoFavor(VideoFavoriteModel videoFav) {
    if (videoDb.values.contains(videoFav.videoPath)) {
      return true;
    } else {
      return false;
    }
  }

  videoAdd(VideoFavoriteModel value, context) {
    videoDb.add(value.videoPath);
    videoFavoriteDb.add(value);
    notifyListeners();
    snackBar(
      context: context,
      content: "video added to favorite",
      width: 3,
      inTotal: 5,
    );
  }

  videoDelete(String videoPath, context) {
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
    videoFavoriteDb.removeWhere((element) => element.videoPath == videoPath);
    notifyListeners();
  }

  clearVideos() async{
    await videoDB.clear();
    videoFavoriteDb.clear();
    notifyListeners();
  }
}

snackBar(
    {required BuildContext context,
    required content,
    required double width,
    required int inTotal,
    function}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: MediaQuery.of(context).size.width * width / inTotal,
      duration: const Duration(seconds: 1),
      content: SizedBox(
        height: 17,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage('assets/icon/icon.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                content,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 48, 47, 47),
      behavior: SnackBarBehavior.floating,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
