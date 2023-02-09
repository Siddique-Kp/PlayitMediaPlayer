import 'package:flutter/material.dart';
import 'package:playit/screens/video/video_bottom_sheet/video_bottom_sheet.dart';
import 'package:playit/screens/video/video_thumbnail.dart';

class VideoDetailsePage extends StatefulWidget {
  const VideoDetailsePage(
      {super.key, required this.videoPath, required this.duration});
  final String videoPath;
  final dynamic duration;

  @override
  State<VideoDetailsePage> createState() => _VideoDetailsePageState();
}

class _VideoDetailsePageState extends State<VideoDetailsePage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: bottomIcon(Icons.info),
      title: bottomText("Details"),
      onTap: () {
        Navigator.pop(context);
        videoDetails();
      },
    );
  }

  videoDetails() {
    showDialog(
      context: context,
      builder: (context) {
        //----------- All information
        String videoName = widget.videoPath.split('/').last;

        String duration = widget.duration.toString().split('0:0').last;
        String format = videoName.split('.').last;

        return SimpleDialog(
          children: [
            const SimpleDialogOption(
              child: Text(
                "Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
           const SizedBox(height: 20,),

            //---------------- video Title
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
                      child: Text(videoName, overflow: TextOverflow.clip)),
                ],
              ),
            ),

            //---------------- video Duration
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
                      child: Text(duration)),
                ],
              ),
            ),
            //---------------- video Duration
            SimpleDialogOption(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1.5 / 10,
                      child: const Text('Format')),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Text(format)),
                ],
              ),
            ),
            //---------------- video Size
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
                      child: Text(fileSize(widget.videoPath))),
                ],
              ),
            ),
            //---------------- video Path
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
                      widget.videoPath,
                      overflow: TextOverflow.clip,
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
