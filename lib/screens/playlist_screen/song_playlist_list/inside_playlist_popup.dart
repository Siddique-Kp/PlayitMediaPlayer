import 'package:flutter/material.dart';
import '../../../database/song_playlist_db.dart';
import '../../../database/video_favorite_db.dart';
import '../../../model/playit_media_model.dart';
import 'add_songs_playlist.dart';

class InsidePopupSong extends StatelessWidget {
  const InsidePopupSong(
      {super.key, required this.playlist, required this.index});
  final dynamic playlist;
  final int index;

  final TextStyle popupStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Text("Add Songs", style: popupStyle),
        ),
        PopupMenuItem(
          value: 2,
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Text("Clear all", style: popupStyle),
        ),
      ],
      offset: const Offset(0, 50),
      // color: const Color.fromARGB(255, 48, 47, 47),
      color: Colors.white,
      elevation: 4,
      onSelected: (value) {
        if (value == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSongsPlaylist(playlist: playlist),
              ));
        }
        if (value == 2) {
          clearPlaylist(context, playlist);
        }
      },
    );
  }

  clearPlaylist(
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
                SongPlaylistDb.playlistNotifiier.notifyListeners();

                snackBar(
                    inTotal: 3,
                    width: 2,
                    context: context,
                    content: "Playlist cleared successfully",
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
