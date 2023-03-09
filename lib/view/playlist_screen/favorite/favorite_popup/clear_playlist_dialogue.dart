import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/database/song_favorite_db.dart';
import '../../../../controller/database/video_favorite_db.dart';

class ClearPlaylist {

 static clearFavorite(bool isVideo, context) {
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
            isVideo
                ? const Text(
                    "All videos will be cleared\n from this favorites",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
                : const Text(
                    "All Songs will be cleared\n from this favorites",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
            isVideo
                ? GestureDetector(
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

                      VideoFavoriteDb.videoFavoriteDb.value.clear();
                      VideoFavoriteDb.videoDb.clear();
                      VideoFavoriteDb.videoFavoriteDb.notifyListeners();

                      snackBar(
                        inTotal: 3,
                        width: 2,
                        context: context,
                        content: "Favorite cleared successfully",
                      );
                    },
                  )
                : GestureDetector(
                    child: const SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          "Clear all songs",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Provider.of<MusicFavController>(context, listen: false)
                          .clear();
                      snackBar(
                        inTotal: 3,
                        width: 2.5,
                        context: context,
                        content: "Favorite cleared successfully",
                      );
                    },
                  ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(thickness: 1),
            ),
            GestureDetector(
              child: const SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
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