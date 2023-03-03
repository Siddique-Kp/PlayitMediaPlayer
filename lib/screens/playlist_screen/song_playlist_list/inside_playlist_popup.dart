import 'package:flutter/material.dart';
import 'package:playit/database/player_db.dart';
import 'package:playit/model/player.dart';
import 'package:provider/provider.dart';
import '../../../database/song_playlist_db.dart';
import '../../../database/video_favorite_db.dart';
import '../../../model/playit_media_model.dart';
import '../video_playlist_list/add_videos_playlist.dart';
import 'add_songs_playlist.dart';

class InsidePopupSong extends StatelessWidget {
  const InsidePopupSong({
    super.key,
    this.playlist,
    this.videoPlalist,
    required this.isVideo,
    required this.index,
  });
  final PlayItSongModel? playlist;
  final PlayerModel? videoPlalist;
  final bool isVideo;
  final int index;

  final TextStyle popupStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: isVideo
              ? Text("Add Videos", style: popupStyle)
              : Text("Add Songs", style: popupStyle),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Clear all", style: popupStyle),
        ),
      ],
      offset: const Offset(0, 10),
      // color: const Color.fromARGB(255, 48, 47, 47),
      color: Colors.white,
      elevation: 4,
      onSelected: (value) {
        if (isVideo) {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddVideosToPlayList(
                  playlist: videoPlalist!,
                ),
              ),
            );
          }
          if (value == 2) {
            clearVideoPlaylist(context, videoPlalist!);
          }
        } else {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSongsPlaylist(playlist: playlist!),
              ),
            );
          }
          if (value == 2) {
            clearSongPlaylist(context, playlist!);
          }
        }
      },
    );
  }

  clearSongPlaylist(
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
                Provider.of<SongPlaylistDb>(context, listen: false)
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

  clearVideoPlaylist(
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
