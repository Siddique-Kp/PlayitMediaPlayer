import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/videos/access_video.dart';
import 'package:intl/intl.dart';

class SongDetails extends StatelessWidget {
  const SongDetails(
      {super.key, required this.artistName, required this.songModel});
  final dynamic artistName;
  final SongModel songModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: bottomIcon(Icons.info),
      title: bottomText('Song info'),
      onTap: () {
        Navigator.pop(context);
        songDetails(context);
      },
    );
  }

  Widget bottomText(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
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

  songDetails(context) {
    showDialog(
      context: context,
      builder: (context) {
        //----------- All information
        String songTitle = songModel.displayNameWOExt;
        String albumName = songModel.album!;
        String songPath = songModel.uri.toString();
        int totalDuration = songModel.duration!;
        double seconds = totalDuration / 1000;
        dynamic duration = convertSecond(seconds);
        int songSize = songModel.size;
        dynamic size = formatSize(songSize);
        
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.6 / 10,
                      child: const Text('Name')),
                  Expanded(
                    child: Text(songTitle,
                        softWrap: true,),
                  ),
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
                      width: MediaQuery.of(context).size.width * 1.6 / 10,
                      child: const Text('Artist')),
                  Expanded(
                    child: Text(
                      artistName,
                      softWrap: true,
                    ),
                  ),
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
                      width: MediaQuery.of(context).size.width * 1.6 / 10,
                      child: const Text('Album')),
                  Expanded(
                    child: Text(
                      albumName,
                      softWrap: true,
                    ),
                  ),
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
                      width: MediaQuery.of(context).size.width * 1.6 / 10,
                      child: const Text('Duration')),
                  Expanded(child: Text(duration.toString().split('0:0').last,softWrap: true,)),
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
                      width: MediaQuery.of(context).size.width * 1.6 / 10,
                      child: const Text('Size')),
                  Expanded(child: Text(size.toString(),softWrap: true,)),
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
                      width: MediaQuery.of(context).size.width * 1.6 / 10,
                      child: const Text('Path')),
                  Expanded(
                    child: Text(
                      songPath,
                      overflow: TextOverflow.clip,
                      softWrap: true,
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

  String formatSize(int sizeInBytes) {
  if (sizeInBytes < 1024) {
    return '$sizeInBytes B';
  } else if (sizeInBytes < 1024 * 1024) {
    double sizeInKB = sizeInBytes / 1024;
    return '${formatNumber(sizeInKB)} KB';
  } else if (sizeInBytes < 1024 * 1024 * 1024) {
    double sizeInMB = sizeInBytes / (1024 * 1024);
    return '${formatNumber(sizeInMB)} MB';
  } else {
    double sizeInGB = sizeInBytes / (1024 * 1024 * 1024);
    return '${formatNumber(sizeInGB)} GB';
  }
}

String formatNumber(double number) {
  final format = NumberFormat('###,###,###.##');
  return format.format(number);
}
}
