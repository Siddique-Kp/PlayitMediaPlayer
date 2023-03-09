import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/database/song_favorite_db.dart';
import 'package:playit/view/music/view/mini_player/mini_player_sheet.dart';
import 'package:playit/view/music/view/music_page/songs/song_list_builder.dart';
import 'package:playit/view/playlist_screen/favorite_video/favorite_popup.dart';
import 'package:provider/provider.dart';

class FavoriteSongs extends StatefulWidget {
  const FavoriteSongs({super.key});

  @override
  State<FavoriteSongs> createState() => _FavoriteSongsState();
}

class _FavoriteSongsState extends State<FavoriteSongs> {
  List<SongModel> favoriteData = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicFavController>(
    
      builder: (context, musicFavController, child){
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.black,
            title: const Text("Favorite Songs"),
            actions: const [FavoritePopUp(isVideo: false)],
          ),
          body: Consumer<MusicFavController>(
          
            builder: (context, musicFavController, child){
              final temp = musicFavController.favoriteSongs.reversed.toList();
              favoriteData = temp.toSet().toList();

              if (favoriteData.isEmpty) {
                return const Center(
                  child: Text(
                    "No Favorite Songs",
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 64, 64),
                      fontSize: 17,
                    ),
                  ),
                );
              } else {
                return SongListBuilder(
                  songModel: favoriteData,
                  isFavor: true,
                );
              }
            },
          ),
          bottomSheet: const MiniPlayerSheet(),
        );
      },
    );
  }
}
