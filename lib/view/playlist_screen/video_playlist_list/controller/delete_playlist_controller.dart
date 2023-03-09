import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../model/database/video_favorite_db.dart';
import '../../../../model/player.dart';

class DeletePlayListController {
  //---- Delete video playlist

  static deleteVideoPlayList(
    BuildContext context,
    Box<PlayerModel> videoList,
    int index,
  ) {
    return showDialog(
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
                    "Delete",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                videoList.deleteAt(index);

                snackBar(
                  inTotal: 4,
                  width: 3,
                  context: context,
                  content: "Deleted successfully",
                );
              },
            ),
            const Divider(thickness: 1),
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
