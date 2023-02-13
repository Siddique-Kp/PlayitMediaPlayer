import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/video_favorite_db.dart';
import '../../../../database/song_favorite_db.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.songFavorite});
  final SongModel songFavorite;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder:
            (BuildContext ctx, List<SongModel> favoriteData, Widget? child) {
          return IconButton(
              onPressed: () {
                if (FavoriteDb.isFavor(songFavorite)) {
                  FavoriteDb.delete(songFavorite.id);
                } else {
                  FavoriteDb.add(songFavorite);
                  snackBar(
                      context: context,
                      content: "Added To Favorite",
                      width: 2,
                      inTotal: 4,
                      bgcolor: const Color.fromARGB(255, 41, 41, 56));
                }
                FavoriteDb.favoriteSongs.notifyListeners();
              },
              icon: FavoriteDb.isFavor(songFavorite)
                  ? const Icon(Icons.favorite, color: Colors.redAccent)
                  : const Icon(Icons.favorite_outline, color: Colors.white));
        });
  }
}
