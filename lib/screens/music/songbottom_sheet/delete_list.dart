import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/songbottom_sheet/widgets/icons.dart';
import 'package:playit/screens/music/songbottom_sheet/widgets/text.dart';
import '../../../database/video_favorite_db.dart';
import '../../../model/playit_media_model.dart';

class SongDelete extends StatelessWidget {
  final bool isPlaylist;
  final dynamic playList;
  final SongModel songModel;


  const SongDelete({
    super.key,
    required this.isPlaylist,
    required this.playList,
    required this.songModel,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isPlaylist,
      child: ListTile(
        leading: bottomIcon(Icons.delete),
        title: bottomText("Delete"),
        onTap: () {
          Navigator.pop(context);
          showdialog(playList, songModel, context);
        },
      ),
    );
  }

  showdialog(
    PlayItSongModel playlist,
    SongModel songPlaylist,
    context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Remove from playlist",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
                playlist.deleteData(songPlaylist.id);
                snackBar(
                  inTotal: 4,
                  width: 3,
                  context: context,
                  content: "Deleted successfully",
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

 

  
}
