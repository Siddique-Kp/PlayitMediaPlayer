import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/view/music/view/songbottom_sheet/widgets/icons.dart';
import 'package:playit/view/music/view/songbottom_sheet/widgets/text.dart';

import '../../../../../controller/database/song_favorite_db.dart';
import '../../../../../controller/database/video_favorite_db.dart';

class AddToFavorite extends StatelessWidget {
  final SongModel songFavorite;
  final bool isFavor;
  const AddToFavorite({
    super.key,
    required this.songFavorite,
    required this.isFavor,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState){
        return FavoriteDb.isFavor(songFavorite)
            ? ListTile(
                leading: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 27,
                  ),
                ),
                title: bottomText(
                  "Added To Favorite",
                ),
                onTap: () {
                  setState(() {
                    FavoriteDb.delete(songFavorite.id);
                  });
                  if (isFavor) {
                    Navigator.pop(context);
                  }
                },
              )
            : ListTile(
                leading: bottomIcon(Icons.favorite_border_outlined),
                title: bottomText("Add To Favorite"),
                onTap: () {
                  setState(() {
                    FavoriteDb.add(songFavorite);
                  });

                  snackBar(
                    context: context,
                    content: "Song added to favorite",
                    width: 3,
                    inTotal: 5,
                  );
                },
              );
      }
    );
  }
}
