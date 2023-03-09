import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/model/playit_media_model.dart';

import '../database/video_favorite_db.dart';

class MusicPlaylistController with ChangeNotifier {
  addSongsToPlaylist({
    required PlayItSongModel songModel,
    required SongModel data,
    required context
  }) {
    songModel.add(data.id);
    notifyListeners();
    snackBar(
      inTotal: 2,
      width: 1,
      context: context,
      content: "Song Added",
    );
    
  }

  removeSongsFromPlaylist({
    required PlayItSongModel songModel,
    required SongModel data,
  }) {
    songModel.deleteData(data.id);
    notifyListeners();
  }
}
