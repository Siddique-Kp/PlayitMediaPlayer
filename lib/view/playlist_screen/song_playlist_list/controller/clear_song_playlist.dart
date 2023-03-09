import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/database/music_playlist_db_controller.dart';
import '../../../../controller/database/video_favorite_db.dart';
import '../../../../model/playit_media_model.dart';

class ClearSongPlaylist {

  //---------- Clears all the songs from playlist
 static clearSongPlaylist(
    BuildContext context,
    PlayItSongModel data,
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
              "All songs in this playlist\n will be cleared",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Clear all songs",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
                data.clearSongs();
                Provider.of<MusicPlaylistDbController>(context, listen: false)
                    .getAllPlaylist();

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
