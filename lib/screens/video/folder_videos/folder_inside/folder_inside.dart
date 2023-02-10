import 'package:flutter/material.dart';
import 'package:playit/screens/video/folder_videos/accsess_folder.dart';
import 'package:playit/screens/video/video_list/video_list_builder.dart';
import '../../../../main.dart';
import '../../../../model/playit_media_model.dart';

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
                  String videoPath = videos[index];
                  String videoTitle = videoPath.split('/').last;
                  String shorttitle = videoTitle;
                  if (videoTitle.length > 19) {
                    shorttitle = shorttitle.substring(0, 19);
                  }
                  AllVideos? info = videoDB.getAt(index);
                  String duration = info!.duration.split('.').first;
                  return VideoListBuilder(
                    videoPath: videoPath,
                    videoTitle: shorttitle,
                    duration: duration,
                    index: index,
                  );
                },
              );
            }));
  }
}
