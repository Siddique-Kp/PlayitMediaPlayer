import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/video/access_video.dart';

class SongDetails extends StatefulWidget {
  const SongDetails(
      {super.key, required this.artistName, required this.songModel});
  final dynamic artistName;
  final SongModel songModel;

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: bottomIcon(Icons.info),
      title: bottomText('Song info'),
      onTap: () {
        Navigator.pop(context);
        songDetails();
      },
    );
  }

  Widget bottomText(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget bottomIcon(icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Icon(
        icon,
        size: 27,
        color: const Color.fromARGB(255, 21, 21, 21),
      ),
    );
  }

  songDetails() {
    showDialog(
      context: context,
      builder: (context) {
        //----------- All information
        String songTitle = widget.songModel.displayNameWOExt;
        String albumName = widget.songModel.album!;
        String songPath = widget.songModel.uri!;
        int totalDuration = widget.songModel.duration!;
        double seconds = totalDuration / 1000;
        dynamic duration = convertSecond(seconds);
        int songSize = widget.songModel.size;
        double size = songSize / 1024;
        double siiize = size / 1024;
        return SimpleDialog(
          children: [
            const SimpleDialogOption(
              child: Text(
                "Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //---------------- Song Title
            SimpleDialogOption(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.5 / 10,
                      child: const Text('Name')),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Text(songTitle,
                          overflow: TextOverflow.clip, maxLines: 3)),
                ],
              ),
            ),
            //---------------- Song Artist
            SimpleDialogOption(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.5 / 10,
                      child: const Text('Artist')),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Text(
                        widget.artistName,
                        overflow: TextOverflow.clip,
                      )),
                ],
              ),
            ),
            //---------------- Song Artist
            SimpleDialogOption(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.5 / 10,
                      child: const Text('Album')),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Text(
                        albumName,
                        overflow: TextOverflow.clip,
                      )),
                ],
              ),
            ),
            //---------------- Song Duration
            SimpleDialogOption(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.5 / 10,
                      child: const Text('Duration')),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Text(duration.toString().split('0:0').last)),
                ],
              ),
            ),
            //---------------- Song Size
            SimpleDialogOption(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.5 / 10,
                      child: const Text('Size')),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Text(siiize.toString())),
                ],
              ),
            ),
            //---------------- Song Path
            SimpleDialogOption(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.5 / 10,
                      child: const Text('Path')),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    child: Text(
                      songPath,
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SimpleDialogOption(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
