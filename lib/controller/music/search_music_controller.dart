import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'get_all_songs_controller.dart';
import '../database/song_favorite_db.dart';

class SearchMusicController with ChangeNotifier {
  List<SongModel> _foundSong = [];
  List<SongModel> _result = [];
  List<SongModel> _allSongs = [];

  List<SongModel> get foundSong => _foundSong;
  List<SongModel> get result => _result;
  List<SongModel> get allSongs => _allSongs;

  void setFoundSongs(result) {
    _foundSong = result;
    notifyListeners();
  }

  void updateList(String searchText) {
    if (searchText.isEmpty) {
      _result = _allSongs;
    } else {
      _result = _allSongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
    setFoundSongs(_result);
    notifyListeners();
  }

  loadSongs(isFavSong, context) {
    _allSongs = isFavSong
        ? MusicFavController.favoriteSongs
        : GetAllSongController.songscopy;
    _foundSong = allSongs;
  }

  onClearTextField(isFavSong, context) {
    loadSongs(isFavSong, context);
    notifyListeners();
  }
}
