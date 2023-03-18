import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'get_all_songs_controller.dart';

class NowPlayingController with ChangeNotifier {
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

class NowPlayingPageController with ChangeNotifier {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  int _currentIndex = 0;
  bool _firstSong = false;
  bool _lastSong = false;
  int _large = 0;

  Duration get duration => _duration;
  Duration get position => _position;
  int get cuttentIndex => _currentIndex;
  bool get firstSong => _firstSong;
  bool get lastSong => _lastSong;
  int get large => _large;
  String get formatDuration => _formatDuration(duration);
  String get formatPosition => _formatDuration(position);

  void initState(count) {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        GetAllSongController.currentIndexes = index;
        setState(index, count);
      }
    });
    deviceOrientation();
    playSong();
    notifyListeners();
  }

  deviceOrientation() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    notifyListeners();
  }

  playSong() {
    GetAllSongController.audioPlayer.durationStream.listen((d) {
      setDuration(d);
    });
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      setPositon(p);
    });
    notifyListeners();
  }

  setState(index, count) {
    _large = count - 1; //store the last song's index number
    _currentIndex = index;
    index == 0 ? _firstSong = true : _firstSong = false;
    index == _large ? _lastSong = true : _lastSong = false;
    notifyListeners();
  }

  setPositon(p) {
    _position = p;
    notifyListeners();
  }

  setDuration(d) {
    if (d != null) {
      _duration = d;
      notifyListeners();
    }
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }
}
