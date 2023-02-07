import 'package:flutter/material.dart';
import 'package:playit/screens/video/access_video.dart';
import 'package:playit/screens/video/folder_videos/accsess_folder.dart';
import 'package:playit/screens/video/video_thumbnail.dart';
import '../../../../main.dart';
import '../../../../model/playit_media_model.dart';
import '../../playing_video_screen/playing_video.dart';
import '../../video_bottom_sheet/video_bottom_sheet.dart';

class FolderVideoInside extends StatefulWidget {
  const FolderVideoInside({super.key, required this.folderPath});
  final String folderPath;

  @override
  State<FolderVideoInside> createState() => _FolderVideoInsideState();
}

class _FolderVideoInsideState extends State<FolderVideoInside> {
  @override
  void initState() {
    loadVideos(widget.folderPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.folderPath.split('/').last),
        ),
        body: ValueListenableBuilder(
            valueListenable: folderVideos,
            builder: (context, videos, child) {
              if (videos.isEmpty) {
                return const Center(
                  child: Text("No video found"),
                );
              }
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  String videoTitle = videos[index].split('/').last;
                  AllVideos? videoinfo = videoDB.getAt(index);
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayingVideo(
                            videoFile: videos[index],
                            videoTitle: videoTitle,
                          ),
                        ),
                      );
                    },
                    leading: thumbnail(
                        path: videos[index],
                        context: context,
                        duration: videoinfo!.duration.toString().split('.').first),
                    title: Text(
                      videoTitle,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                    subtitle: Text(fileSize(videos[index])),
                    trailing: VideoBottomSheet(
                      videoTitle: videoTitle,
                      videoPath: videos[index],
                      videoSize: fileSize(videos[index]),
                      duration: loadVideoduration()
                          .toString()
                          .split('.')
                          .first,
                      index: index,
                    ),
                  );
                },
              );
            }));
  }


}
