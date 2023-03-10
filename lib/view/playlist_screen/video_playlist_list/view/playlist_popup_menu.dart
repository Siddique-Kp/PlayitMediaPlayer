import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/player.dart';
import '../controller/delete_playlist_controller.dart';
import '../controller/edit_playlist_controller.dart';

class PlayListPopUpVideo extends StatelessWidget {
  const PlayListPopUpVideo({
    super.key,
    required this.playlist,
    required this.videoPlayitList,
    required this.index,
  });
  final PlayerModel playlist;
  final Box<PlayerModel> videoPlayitList;
  final int index;

  final TextStyle popupStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    List<String> listVideos = [];
    final playerModelBox = Hive.box<PlayerModel>('PlayerDB').listenable();
    return ValueListenableBuilder(
      valueListenable: playerModelBox,
      builder: (context, Box<PlayerModel> videos, child) {
        listVideos = videos.values.toList()[index].videoPath;
        return PopupMenuButton<int>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 2,
              child: Text(
                "Rename",
                style: popupStyle,
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Text(
                "Delete",
                style: popupStyle,
              ),
            )
          ],
          // offset: const Offset(0, 50),
          color: const Color.fromARGB(255, 75, 75, 75),
          elevation: 2,
          onSelected: (value) {
            if (value == 2) {
              EditPlayListController.editVideoPlaylistName(
                context,
                playlist,
                index,
                listVideos,
              );
            } else if (value == 3) {
              DeletePlayListController.deleteVideoPlayList(
                context,
                videoPlayitList,
                index,
              );
            }
          },
        );
      },
    );
  }
}
