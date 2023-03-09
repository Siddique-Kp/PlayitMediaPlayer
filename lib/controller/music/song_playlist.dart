import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/model/playit_media_model.dart';

import '../../model/database/video_favorite_db.dart';

class SongPlylistProvider with ChangeNotifier {
  addSongsToPlaylist({
    required PlayItSongModel songModel,
    required SongModel data,
    required context
  }) {
    songModel.add(data.id);
    snackBar(
      inTotal: 2,
      width: 1,
      context: context,
      content: "Song Added",
    );
    notifyListeners();
  }

  removeSongsFromPlaylist({
    required PlayItSongModel songModel,
    required SongModel data,
  }) {
    songModel.deleteData(data.id);
    notifyListeners();
  }
}
