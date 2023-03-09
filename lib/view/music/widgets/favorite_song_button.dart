import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/database/video_favorite_db.dart';
import 'package:provider/provider.dart';
import '../../../controller/database/song_favorite_db.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.songFavorite,
  });
  final SongModel songFavorite;
  @override
  Widget build(BuildContext context) {
    return Consumer<MusicFavController>(
      
      builder:(context, musicFavController, child){
        return IconButton(
          onPressed: () {
            if (musicFavController.isFavor(songFavorite)) {
              musicFavController.delete(songFavorite.id);
            } else {
              musicFavController.add(songFavorite);
              snackBar(
                context: context,
                content: "Added To Favorite",
                width: 2,
                inTotal: 4,
              );
            }
          },
          icon: musicFavController.isFavor(songFavorite)
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
