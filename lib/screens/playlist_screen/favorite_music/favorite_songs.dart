import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/song_favorite_db.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';
import 'package:playit/screens/playlist_screen/favorite_video/favorite_popup.dart';

class FavoriteSongs extends StatefulWidget {
  const FavoriteSongs({super.key});

  @override
  State<FavoriteSongs> createState() => _FavoriteSongsState();
}

class _FavoriteSongsState extends State<FavoriteSongs> {
  List<SongModel> favoriteData = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder: (context, List<SongModel> favoriteSongData, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.black,
              title: const Text("Favorite Songs"),
              actions:const [
                FavoritePopUp(isVideo: false)
              ],
            ),
            body: ValueListenableBuilder(
                valueListenable: FavoriteDb.favoriteSongs,
                builder: (context, List<SongModel> favoriteSongData, child) {
                  final temp = favoriteSongData.reversed.toList();
                  favoriteData = temp.toSet().toList();

                  if (favoriteData.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Favorite Songs",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    );
                  } else {
                    return SongListBuilder(
                      songModel: favoriteData,
                      isFavor: true,
                    );
                  }
                }),
          );
        });
  }
}
