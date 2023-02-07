import 'package:flutter/material.dart';
import 'package:playit/database/video_playlist_db.dart';
import 'package:playit/screens/video/playing_video_screen/playing_video.dart';
import 'package:playit/screens/video/video_bottom_sheet/video_bottom_sheet.dart';
import 'package:playit/screens/video/video_thumbnail.dart';
import '../../../model/playit_media_model.dart';
import 'add_videos_playlist.dart';

class VideoPlayListList extends StatefulWidget {
  const VideoPlayListList({
    super.key,
    required this.playList,
    required this.listIndex,
  });
  final VideoPlaylistModel playList;
  final int listIndex;

  @override
  State<VideoPlayListList> createState() => _VideoPlayListListState();
}

class _VideoPlayListListState extends State<VideoPlayListList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.playList.name),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddVideosToPlayList(
                            playlist: widget.playList,
                            playlistFolderIndex: widget.playList.index
                            
                            ),
                      ));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: VideoPlaylistDb.playlistitemsNotifier,
          builder: (
            context,
            List<VideoPlayListItem> videoPlaylistItems,
            child,
          ) {
            if (videoPlaylistItems.isEmpty) {
              return const Center(
                child: Text("No Videos in this Playlist"),
              );
            } else {
              return ListView.builder(
                itemCount: videoPlaylistItems.length,
                itemBuilder: (context, index) {
                  final data = videoPlaylistItems[index];
                  String videoTitle = data.videoPath.toString().split('/').last;
                  String shorttitle = videoTitle;
                  if (videoTitle.length > 19) {
                    shorttitle = shorttitle.substring(0, 19);
                  }

                  if (widget.playList.index == data.playlistFolderindex) {
                    return ListTile(
                      leading: thumbnail(
                          path: data.videoPath,
                          context: context,
                          duration: data.duration),
                      title: Text(
                        shorttitle,
                      ),
                      subtitle: Text(fileSize(data.videoPath)),
                      trailing: VideoBottomSheet(
                        videoTitle: videoTitle,
                        videoPath: data.videoPath,
                        videoSize: fileSize(data.videoPath),
                        duration: data.duration,
                        index: index,
                        isPlaylist: true,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayingVideo(
                            videoFile: data.videoPath,
                            videoTitle: videoTitle,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            }
          },
        ));
  }
}
