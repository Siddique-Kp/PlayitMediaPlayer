import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/view/videos/video/controller/access_video.dart';
import 'package:playit/view/videos/folder_videos/controller/accsess_folder.dart';
import 'package:playit/view/videos/folder_videos/view/folder_video_list.dart';

class FolderVideoList extends StatefulWidget {
  const FolderVideoList({super.key});

  @override
  State<FolderVideoList> createState() => _FolderVideoListState();
}

class _FolderVideoListState extends State<FolderVideoList> {
  @override
  void initState() {
    getPermmission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requestPermission(Permission.storage),
      builder: (context, items) {
        if (items.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ValueListenableBuilder(
          valueListenable: loadFolders,
          builder: (context, List<String> folderList, child) {
            return folderList.isEmpty
                ? const Center(
                    child: Text('No Folders'),
                  )
                : ListView.builder(
                    itemExtent: 90,
                    itemCount: folderList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.folder,
                          size: 95,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: Text(
                            loadFolders.value[index].split('/').last,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return FolderVideoInside(
                                    folderPath: loadFolders.value[index]);
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
          },
        );
      },
    );
  }

  getPermmission() async {
    if (await requestPermission(Permission.storage)) {
      setState(() {});
    }
  }
}
