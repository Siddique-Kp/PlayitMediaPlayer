import 'package:flutter/material.dart';
import 'package:playit/view/playlist_screen/song_playlist_list/view/playlist.dart';
import 'package:playit/view/playlist_screen/favorite/favorite_music/favorite_songs.dart';
import 'package:playit/view/playlist_screen/floating_button.dart/view/floating_button.dart';
import 'package:playit/view/playlist_screen/video_playlist_list/view/play_list.dart';
import '../../favorite/favorite_video/favorite_videos.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    //  final musicHivebox = Hive.box<PlayItSongModel>('songplaylistDb');
    //  final videoHivebox = Hive.box<PlayerModel>('PlayerDB');
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: const Text('Playlist'),

        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          secondHeading('Favorites'),
          const SizedBox(
            height: 20,
          ),
          // ------------ container for Favorite music--------------
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteSongs(),
                )),
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 229, 12, 12),
                    Color.fromARGB(161, 205, 25, 25),
                    Color.fromARGB(113, 215, 21, 21),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Favorite Songs",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              size: 35,
            ),
          ),
          const SizedBox(height: 20),
          // ------------ container for liked videos--------------
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteVideos(),
                )),
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 12, 63, 229),
                    Color.fromARGB(160, 25, 88, 205),
                    Color.fromARGB(112, 21, 66, 215),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Liked Videos",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              size: 35,
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // ------------ New Playlist view -----------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              secondHeading('Song Playlist'),
              const SizedBox(
                height: 10,
              ),
              const NewMusicPlaylist(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              secondHeading('Video Playlist'),
              const SizedBox(
                height: 10,
              ),
              const PlaylistOfVideo(),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ],
      ),
      // ---------- Floating Button ---------------
      floatingActionButton: const FloatingButton(),
    );
  }

  secondHeading(data) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        data,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
