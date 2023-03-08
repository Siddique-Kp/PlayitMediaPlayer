import 'package:flutter/cupertino.dart';
import '../../core/values.dart';

class MusicButtonsProvider with ChangeNotifier {
  void selectedListTile(int songId) {
    selectedIndex = songId;
    notifyListeners();
  }
}
