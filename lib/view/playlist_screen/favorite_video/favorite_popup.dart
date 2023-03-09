import 'package:flutter/material.dart';
import 'package:playit/view/music/view/search_song/search_song.dart';
import 'package:playit/view/videos/search_video/search_video.dart';
import '../../../controller/database/song_favorite_db.dart';
import '../../../controller/database/video_favorite_db.dart';

class FavoritePopUp extends StatelessWidget {
  const FavoritePopUp({
    super.key,
    required this.isVideo,
  });
  final bool isVideo;

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
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            'Clear all',
            style: popupStyle,
          ),
        ),
      ],
      offset: const Offset(0, 10),
      color: const Color.fromARGB(255, 75, 75, 75),
      elevation: 2,
      onSelected: (value) {
        if (isVideo) {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchVideoPage(isFavVideos: true),
              ),
            );
          } else if (value == 2) {
            clearFavorite(true, context);
          }
        } else {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchSongPage(isFavSong: true),
              ),
            );
          } else if (value == 2) {
            clearFavorite(false, context);
          }
        }
      },
    );
  }

  clearFavorite(bool isVideo, context) {
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
                ? InkWell(
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
                : InkWell(
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
                      FavoriteDb.musicDb.clear();
                      FavoriteDb.clear();
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
            InkWell(
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
