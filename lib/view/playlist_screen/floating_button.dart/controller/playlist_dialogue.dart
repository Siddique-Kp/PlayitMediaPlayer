import 'package:flutter/material.dart';

import 'create_music_playlist.dart';
import 'create_video_playlist.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController textEditingController = TextEditingController();

class PlayListDialogue {
  static newPlayList(
    BuildContext context,
    String text,
    bool isMusicPlaylist,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 48, 47, 47),
          children: [
            SimpleDialogOption(
              child: Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: SimpleDialogOption(
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    controller: textEditingController,
                    maxLength: 15,
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white.withOpacity(0.7),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      contentPadding: const EdgeInsets.only(left: 15, top: 5),
                    ),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your playlist name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    textEditingController.clear();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (isMusicPlaylist == true) {
                        CreateMusicPlaylist.createMusicPlaylist(context);
                      } else {
                        CreateVideoPlaylist.createVideoPlaylist(context);
                      }
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
