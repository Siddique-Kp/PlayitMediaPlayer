import 'package:flutter/cupertino.dart';
import 'package:playit/core/values.dart';
import '../../core/boolians.dart';

class MusicTileProvider with ChangeNotifier {
 
  selectedMusicTile({
    required int playingSongid,
  }) {
    selectedIndex = playingSongid;
    isPlayingSong = true;
    bodyBottomMargin = 50;

    notifyListeners();
  }

  void selectedListTile(int songId) {
    selectedIndex = songId;
    notifyListeners();
  }
}
