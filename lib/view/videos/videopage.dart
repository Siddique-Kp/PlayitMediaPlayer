import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playit/core/colors.dart';
import 'package:playit/view/videos/search_video/search_video.dart';
import 'package:playit/view/videos/video/view/video_list.dart';
import 'folder_videos/view/folder_list.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          // child: FolderVideoList(),

          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                elevation: 0,
                titleTextStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                title: const Text('VIDEO'),
                actions: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.history),
                  // ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SearchVideoPage(isFavVideos: false),
                          ));
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                snap: true,
                bottom: const TabBar(
                  indicatorColor: Colors.deepOrange,
                  tabs: [
                    Tab(
                      child: Text(
                        "Video",
                        style: TextStyle(
                          fontSize: 17,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Folder",
                        style: TextStyle(
                          fontSize: 17,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            body: const TabBarView(
              children: [
                VideoList(),
                FolderVideoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
