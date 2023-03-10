import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/music/search_music_controller.dart';
import 'package:playit/view/music/view/music_page/songs/song_list_builder.dart';
import 'package:provider/provider.dart';

TextEditingController _searchtext = TextEditingController();

class SearchSongPage extends StatelessWidget {
  SearchSongPage({
    super.key,
    required this.isFavSong,
  });
  final bool isFavSong;

  final audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final searchController =
        Provider.of<SearchMusicController>(context, listen: false);
    List<SongModel> foundSongs =
        context.watch<SearchMusicController>().foundSong;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.loadSongs(isFavSong, context);
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchtext,
                onChanged: (value) => searchController.updateList(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  hintText: 'Search Song',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: InkWell(
                    onTap: () {
                       _searchtext.clear();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  prefixIconColor: Colors.white,
                  suffixIcon: _searchtext.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            _searchtext.clear();
                            searchController.onClearTextField(
                                isFavSong, context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(),
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            foundSongs.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.7 / 2),
                    child: const Center(
                      child: Text('No Result'),
                    ),
                  )
                : Expanded(
                    child: SongListBuilder(
                      songModel: foundSongs,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
