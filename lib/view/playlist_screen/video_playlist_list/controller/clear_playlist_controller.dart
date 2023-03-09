import 'package:flutter/material.dart';

import '../../../../controller/database/player_db.dart';
import '../../../../controller/database/video_favorite_db.dart';
import '../../../../model/player.dart';

class ClearPlaylistController{

  //------- Clears all the videos from the playlist
  static clearVideoPlaylist(
    BuildContext context,
    PlayerModel videoData,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            const Text(
              "All videos in this playlist\n will be cleared",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Clear all videos",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
                videoData.clearSongs();
                VideoPlayerListDB.playerNotify.notifyListeners();

                snackBar(
                  inTotal: 3,
                  width: 2,
                  context: context,
                  content: "Playlist cleared successfully",
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(thickness: 1),
            ),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}