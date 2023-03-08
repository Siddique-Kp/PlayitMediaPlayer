import 'package:flutter/cupertino.dart';

import '../../screens/music/get_all_songs.dart';

class NowPlayingProvider with ChangeNotifier {
  changeSlider(double value) {
    changeSliderValue(value.toInt());
    value = value;
    notifyListeners();
  }

  void changeSliderValue(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }
}
