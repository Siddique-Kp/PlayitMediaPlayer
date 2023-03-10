import 'package:flutter/material.dart';
import 'package:playit/model/player.dart';
import '../../../../model/playit_media_model.dart';
import '../../video_playlist_list/controller/clear_playlist_controller.dart';
import '../../video_playlist_list/view/view_videos_playlist.dart';
import '../controller/clear_song_playlist.dart';
import 'view_songs_list.dart';

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
            ClearPlaylistController.clearVideoPlaylist(
              context,
              videoPlalist!,
            );
          }
        } else {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSongsPlaylist(
                  playlist: playlist!,
                ),
              ),
            );
          }
          if (value == 2) {
            ClearSongPlaylist.clearSongPlaylist(
              context,
              playlist!,
            );
          }
        }
      },
    );
  }
}
