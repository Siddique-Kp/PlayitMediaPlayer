import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/model/player.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/video/access_video.dart';
import '../../../main.dart';
import '../../video/video_thumbnail.dart';

class AddVideosToPlayList extends StatefulWidget {
  const AddVideosToPlayList({super.key, required this.playlist});
  final PlayerModel playlist;

  @override
  State<AddVideosToPlayList> createState() => _AddVideosToPlayListState();
}

class _AddVideosToPlayListState extends State<AddVideosToPlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Videos To Playlist")),
      body: FutureBuilder(
        future: requestPermission(Permission.storage),
        builder: (context, items) {
          if (items.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: accessVideosPath.length,
            itemExtent: 75,
            itemBuilder: (context, index) {
              String path = accessVideosPath[index];
              final videoTitle =
                  accessVideosPath[index].toString().split('/').last;
              String shorttitle = videoTitle;
              if (videoTitle.length > 19) {
                shorttitle = shorttitle.substring(0, 19);
              }
              AllVideos? videoinfo = videoDB.getAt(index);

              return ListTile(
                leading: thumbnail(
                  path: path,
                  context: context,
                  duration: videoinfo!.duration.toString().split(".").first,
                ),
                title: Text(
                  shorttitle,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                subtitle: Text(fileSize(path)),
                trailing: !widget.playlist.isValueIn(path)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.playlist.add(path);
                          });
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 10,
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ))
                    : IconButton(
                        onPressed: () {
                          widget.playlist.deleteData(path);
                        },
                        icon: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.horizontal_rule,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
