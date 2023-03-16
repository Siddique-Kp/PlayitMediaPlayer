import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/music/search_music_controller.dart';
import 'package:playit/core/colors.dart';
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
    context.read<SearchMusicController>().loadSongs(isFavSong, context);
    final searchController = context.read<SearchMusicController>();
    List<SongModel> foundSongs =
        context.watch<SearchMusicController>().foundSong;

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
                style: const TextStyle(color: kWhiteColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  hintText: 'Search Song',
                  hintStyle: const TextStyle(color: kWhiteColor),
                  prefixIcon: InkWell(
                    onTap: () {
                      _searchtext.clear();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: kWhiteColor,
                    ),
                  ),
                  prefixIconColor: kWhiteColor,
                  suffixIcon: _searchtext.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            _searchtext.clear();
                            searchController.onClearTextField(
                                isFavSong, context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: kWhiteColor,
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
