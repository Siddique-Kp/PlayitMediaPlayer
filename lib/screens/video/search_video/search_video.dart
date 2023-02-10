import 'package:flutter/material.dart';
import 'package:playit/main.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/video/access_video.dart';
import 'package:playit/screens/video/video_list/video_list_builder.dart';

class SearchVideoPage extends StatefulWidget {
  const SearchVideoPage({super.key});

  @override
  State<SearchVideoPage> createState() => _SearchVideoPageState();
}

class _SearchVideoPageState extends State<SearchVideoPage> {
  List<String> allVideos = [];
  List<String> foundVideo = [];

  @override
  void initState() {
    loadSongs();
    super.initState();
  }

  void updateList(String searchText) {
    List<String> result = [];
    if (searchText.isEmpty) {
      result = allVideos;
    } else {
      result = allVideos
          .where((element) =>
              element.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundVideo = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => updateList(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: 'Search Song',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    prefixIconColor: Colors.white,
                    suffixStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    suffix: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Text("| cancel"))),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Results',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            foundVideo.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.7 / 2),
                    child: const Center(child: Text('No Result')),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: foundVideo.length,
                      itemBuilder: (context, index) {
                        String videoPath = foundVideo[index];
                        String videoTitle = videoPath.split('/').last;
                        AllVideos? info = videoDB.getAt(index);
                        String duration =
                            info!.duration.toString().split('.').first;
                        return VideoListBuilder(
                          videoPath: videoPath,
                          videoTitle: videoTitle,
                          duration: duration,
                          index: index,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  loadSongs() async {
    allVideos = accessVideosPath.toList();
    foundVideo = allVideos;
  }
}
