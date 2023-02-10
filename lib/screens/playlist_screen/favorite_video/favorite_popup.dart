import 'package:flutter/material.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/playlist_screen/favorite_video/favorite_search.dart';

import '../../../database/video_favorite_db.dart';

class FavoritePopUp extends StatefulWidget {
  const FavoritePopUp(
      {super.key, required this.isVideo, this.songmodel});
  final bool isVideo;
  final List<PlayItSongModel>? songmodel;

  @override
  State<FavoritePopUp> createState() => _FavoritePopUpState();
}

class _FavoritePopUpState extends State<FavoritePopUp> {
  final TextStyle popupStyle = const TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
  
   
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 1,
            child: Text(
              'Search',
              style: popupStyle,
            )),
        PopupMenuItem(
            value: 2,
            child: Text(
              'Clear all',
              style: popupStyle,
            )),
      ],
      offset: const Offset(0, 50),
      color: const Color.fromARGB(255, 48, 47, 47),
      elevation: 2,
      onSelected: (value) {
        if (widget.isVideo) {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                   const FavSearchVideoPage(),
              ),
            );
          } else if (value == 2) {
            clearFavoriteVideo();
          }
        } else {
          if (value == 1) {
          } else if (value == 2) {}
        }
      },
    );
  }

  clearFavoriteVideo() {
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
              "All videos will be cleared\n from this favorites",
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

                VideoFavoriteDb.videoFavoriteDb.value.clear();
                VideoFavoriteDb.videoDb.clear();
                VideoFavoriteDb.videoFavoriteDb.notifyListeners();

                snackBar(
                    inTotal: 3,
                    width: 2,
                    context: context,
                    content: "Favorite cleared successfully",
                    bgcolor: const Color.fromARGB(255, 48, 47, 47));
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
