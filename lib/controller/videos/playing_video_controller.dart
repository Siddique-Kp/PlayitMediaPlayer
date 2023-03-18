import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PlayingVideoController with ChangeNotifier {
  bool _isPlaying = false;
  bool _isLocked = false;
  bool _isVisibleScreen = true;
  int _fitIndex = 0;
  bool _isLandscape = false;
  final List<BoxFit> _screenViews = [
    BoxFit.cover,
    BoxFit.fitHeight,
    BoxFit.contain,
  ];

  bool get isPlaying => _isPlaying;
  bool get isLocked => _isLocked;
  bool get isVisibleScreen => _isVisibleScreen;
  int get fitInsex => _fitIndex;
  bool get isLandscape => _isLandscape;
  List<BoxFit> get screenViews => _screenViews;

// --------- change to landscape mode -----------------

  void landScapeMode() {
    _isLandscape = !_isLandscape;
    setLandscape();

    notifyListeners();
  }

//
  Future setLandscape() async {
    if (_isLandscape) {
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
    notifyListeners();
  }
//
//

// ------------ video change screenView button --------

  void changeScreenView() {
    _fitIndex = (_fitIndex + 1) % _screenViews.length;
    notifyListeners();
  }

// ---------- video play and pause button -------------
  playPauseController() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  // ------------ video lock button -------------------

  videoLockButtonController() {
    _isLocked = !_isLocked;
    _isVisibleScreen = _isVisibleScreen;
    lockScreen();
    notifyListeners();
  }

  checkVisible() {
    _isVisibleScreen = true;
    Future.delayed(const Duration(seconds: 5), () => _isVisibleScreen = false);
    notifyListeners();
  }

  Future lockScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
  }

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
