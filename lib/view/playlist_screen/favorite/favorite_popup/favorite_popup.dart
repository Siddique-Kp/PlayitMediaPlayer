import 'package:flutter/material.dart';
import 'package:playit/view/music/view/search_song/search_song.dart';
import 'package:playit/view/videos/search_video/search_video.dart';
import 'clear_playlist_dialogue.dart';

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
            ClearPlaylist.clearFavorite(true, context);
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
            ClearPlaylist.clearFavorite(false, context);
          }
        }
      },
    );
  }

  
}
