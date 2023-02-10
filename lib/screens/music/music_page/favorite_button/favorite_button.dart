import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/video_favorite_db.dart';
import '../../../../database/song_favorite_db.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.songFavorite});
  final SongModel songFavorite;
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder:
            (BuildContext ctx, List<SongModel> favoriteData, Widget? child) {
          return IconButton(
              onPressed: () {
                if (FavoriteDb.isFavor(widget.songFavorite)) {
                  FavoriteDb.delete(widget.songFavorite.id);
                } else {
                  FavoriteDb.add(widget.songFavorite);
                  snackBar(
                      context: context,
                      content: "Added To Favorite",
                      width: 2,
                      inTotal: 4,
                      bgcolor: const Color.fromARGB(255, 41, 41, 56));
                }
                FavoriteDb.favoriteSongs.notifyListeners();
              },
              icon: FavoriteDb.isFavor(widget.songFavorite)
                  ? const Icon(Icons.favorite, color: Colors.redAccent)
                  : const Icon(Icons.favorite_outline, color: Colors.white));
        });
  }
}
