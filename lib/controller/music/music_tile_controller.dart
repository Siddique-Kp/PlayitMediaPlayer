import 'package:flutter/cupertino.dart';
import '../../core/boolians.dart';

class MusicTileController with ChangeNotifier {
  int _selectedIndex = 0;
  double _bodyBottomMargin = 0;

  int get selectedIndex => _selectedIndex;
  double get bodyBottomMargin => _bodyBottomMargin;

  selectedMusicTile({
    required int playingSongid,
  }) {
    _selectedIndex = playingSongid;
    isPlayingSong = true;
    _bodyBottomMargin = 50;

    notifyListeners();
  }

  void selectedListTile(int songId) {
    _selectedIndex = songId;
    notifyListeners();
  }

  Future<void> removeSelectedMusicTile()async {
    _selectedIndex = 0;
    isPlayingSong = false;
    _bodyBottomMargin = 0;
    notifyListeners();
  }
}
