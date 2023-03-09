import 'package:flutter/material.dart';
import '../../../../model/database/player_db.dart';
import '../../../../model/database/video_favorite_db.dart';
import '../../../../model/player.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final TextEditingController _textEditingController = TextEditingController();

class EditPlayListController {
  // ------------ edit video playlist
  static editVideoPlaylistName(
    BuildContext context,
    PlayerModel data,
    int index,
    List<String> videoData,
  ) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 48, 47, 47),
        children: [
          SimpleDialogOption(
            child: Text(
              "Edit Playlist '${data.name}'",
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SimpleDialogOption(
            child: Form(
              key: _formKey,
              child: TextFormField(
                textAlign: TextAlign.left,
                controller: _textEditingController,
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
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  _textEditingController.clear();
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
                  if (_formKey.currentState!.validate()) {
                    final name = _textEditingController.text.trim();
                    if (name.isEmpty) {
                      return;
                    } else {
                      final playlistName =
                          PlayerModel(name: name, videoPath: videoData);
                      final datas = VideoPlayerListDB.videoPlayerListDB.values
                          .map((e) => e.name.trim())
                          .toList();
                      if (datas.contains(playlistName.name)) {
                        snackBar(
                          context: context,
                          content: "Playlist already exist",
                          width: 2,
                          inTotal: 4,
                        );
                        Navigator.of(context).pop();
                        _textEditingController.clear();
                      } else {
                        VideoPlayerListDB.editList(index, playlistName);
                        snackBar(
                          context: context,
                          content: "Playlist updated",
                          width: 2,
                          inTotal: 4,
                        );
                        Navigator.pop(context);
                        _textEditingController.clear();
                      }
                    }
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
