import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/database/video_favorite_db.dart';
import '../../../controller/database/song_favorite_db.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.songFavorite,
  });
  final SongModel songFavorite;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavoriteDb.favoriteSongs,
      builder: (ctx, List<SongModel> favoriteData, _) {
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
              );
            }
          },
          icon: FavoriteDb.isFavor(songFavorite)
              ? const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                )
              : const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
        );
      },
    );
  }
}
