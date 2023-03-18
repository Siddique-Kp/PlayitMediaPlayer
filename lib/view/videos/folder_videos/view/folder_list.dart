import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/controller/videos/access_video_controller.dart';
import 'package:playit/controller/folder/accsess_folder.dart';
import 'package:playit/view/videos/folder_videos/view/folder_video_list.dart';

class FolderVideoList extends StatelessWidget {
  const FolderVideoList({super.key});

  // @override
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
}
