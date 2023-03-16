import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayingVideoController with ChangeNotifier {
//------- video slider ------------ //
  changeSlider(double value, VideoPlayerController controller) {
    changeSliderValue(value.toInt(), controller);
    value = value;
    notifyListeners();
  }

  void changeSliderValue(int seconds, VideoPlayerController controller) {
    Duration duration = Duration(seconds: seconds);
    controller.seekTo(duration);
  }
}
