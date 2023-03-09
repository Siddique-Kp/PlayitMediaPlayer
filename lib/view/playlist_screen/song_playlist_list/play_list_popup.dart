import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/playit_media_model.dart';
import 'controller/delete_song_playlist.dart';
import 'controller/edit_song_playlist.dart';

class PlayListPopUpMusic extends StatelessWidget {
  const PlayListPopUpMusic({
    super.key,
    required this.playlist,
    this.musicPlayitList,
    required this.index,
  });
  final PlayItSongModel playlist;
  final dynamic musicPlayitList;
  final int index;

  final TextStyle _popupStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    List<int> listSongs = [];
    final playitSongModelBox =
        Hive.box<PlayItSongModel>('songPlaylistDb').listenable();
    return ValueListenableBuilder(
      valueListenable: playitSongModelBox,
      builder: (context, Box<PlayItSongModel> songs, child) {
        listSongs = songs.values.toList()[index].songId;
        return PopupMenuButton<int>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 2,
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Text("Rename", style: _popupStyle),
            ),
            PopupMenuItem(
              value: 3,
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Text("Delete", style: _popupStyle),
            )
          ],
          // offset: const Offset(0, 50),
          color: const Color.fromARGB(255, 75, 75, 75),
          elevation: 2,
          onSelected: (value) {
            if (value == 2) {
              EditSongPlaylist.editPlaylistName(
                context,
                playlist,
                index,
                listSongs,
              );
            } else if (value == 3) {
              DeleteSongPlaylist.deletePlayList(
                  context, index);
            }
          },
        );
      },
    );
  }
}
