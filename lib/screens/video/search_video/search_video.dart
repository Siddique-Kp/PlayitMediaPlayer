import 'package:flutter/material.dart';
import 'package:playit/main.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/video/access_video.dart';
import 'package:playit/screens/video/video_list/video_list_builder.dart';
import '../../../database/video_favorite_db.dart';

class SearchVideoPage extends StatefulWidget {
  const SearchVideoPage({super.key, required this.isFavVideos});
  final bool isFavVideos;

  @override
  State<SearchVideoPage> createState() => _SearchVideoPageState();
}

class _SearchVideoPageState extends State<SearchVideoPage> {
  TextEditingController searchtext = TextEditingController();
  List<String> allVideos = [];
  List<String> foundVideo = [];

  @override
  void initState() {
    loadSearchVideo();
    super.initState();
  }

  void updateList(String searchText) {
    List<String> result = [];
    if (searchText.isEmpty) {
      result = allVideos;
    } else {
      result = allVideos
          .where((element) => element
              .split('/')
              .last
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundVideo = result;
    });
  }

  clearSearch() {
    setState(() {
      searchtext.clear();
      loadSearchVideo();
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
                controller: searchtext,
                onChanged: (value) => updateList(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: 'Search Video',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    prefixIconColor: Colors.white,
                    // suffixStyle: const TextStyle(
                    //   color: Colors.white,
                    // ),
                    suffixIcon: searchtext.text.isNotEmpty
                        ? InkWell(
                            onTap: () => clearSearch(),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ))
                        : const SizedBox()
                    // suffixIconColor: Colors.white,
                    // suffix: InkWell(
                    //   onTap: () => Navigator.pop(context),
                    //   child: const Text("| cancel"),
                    // ),
                    ),
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
                          isFavorite: widget.isFavVideos,
                          isSearchVideo: true,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  loadSearchVideo() async {
    allVideos = widget.isFavVideos
        ? VideoFavoriteDb.videoDb.values.toList()
        : accessVideosPath;
    foundVideo = allVideos;
  }
}
