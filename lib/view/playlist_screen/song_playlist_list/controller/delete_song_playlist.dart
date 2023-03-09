import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../model/database/video_favorite_db.dart';
import '../../../../model/playit_media_model.dart';

class DeleteSongPlaylist {

  // ---------- Edit song playlist
  static deletePlayList(
    BuildContext context,
    Box<PlayItSongModel> musicList,
    int index,
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
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
                musicList.deleteAt(index);

                snackBar(
                  inTotal: 4,
                  width: 3,
                  context: context,
                  content: "Deleted successfully",
                );
              },
            ),
            const Divider(thickness: 1),
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