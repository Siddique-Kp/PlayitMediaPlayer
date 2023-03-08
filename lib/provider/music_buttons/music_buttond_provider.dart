import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../core/values.dart';

class MusicButtonsProvider with ChangeNotifier {
  void selectedListTile(int songId) {
    selectedIndex = songId;
    notifyListeners();
  }
}
