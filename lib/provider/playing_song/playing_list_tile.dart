import 'package:flutter/cupertino.dart';

class PlayingListTile with ChangeNotifier {
  int _isSelectedListTile = -1;
  bool _isPlaying = false;
   double _bodyBottomMargin = 0;

  int get isSelectedListTile => _isSelectedListTile;
  bool get isPlaying => _isPlaying;
  double get bodyBottomMargin => _bodyBottomMargin;

  selectedMusicTile({
    required int playingSongid,
    required bool isPlaying,
    required double bodyBottomMargin,
  }) {
    _isSelectedListTile = playingSongid;
    _isPlaying = true;
    _bodyBottomMargin = 50;

    notifyListeners();
  }
}
