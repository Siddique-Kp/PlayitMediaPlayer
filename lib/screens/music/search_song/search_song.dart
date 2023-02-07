import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';

class SearchSongPage extends StatefulWidget {
  const SearchSongPage({super.key});

  @override
  State<SearchSongPage> createState() => _SearchSongPageState();
}

class _SearchSongPageState extends State<SearchSongPage> {
  List<SongModel> allSongs = [];
  List<SongModel> foundSongs = [];
  final audioQuery = OnAudioQuery();

  @override
  void initState() {
    loadSongs();
    super.initState();
  }

  void updateList(String searchText) {
    List<SongModel> result = [];
    if (searchText.isEmpty) {
      result = allSongs;
    } else {
      result = allSongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundSongs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => updateList(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor:  Colors.black,
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
                suffixStyle:const TextStyle(color: Colors.white,),
                suffix: InkWell(
                  onTap: () => Navigator.pop(context),
                  child:const Text("| cancel"))),
                
          ),
        ),
        const SizedBox(height: 5),
        const Padding(
          padding:  EdgeInsets.only(left:15.0),
          child:  Text(
            'Results',
            style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),
          ),
        ),
        foundSongs.isEmpty?
         Padding(
          padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.7/2),
          child:const Center(child:  Text('No Result')),
        ) :
        Expanded(child: SongListBuilder(songModel: foundSongs))
      ]),
    ));
  }

  loadSongs() async {
    allSongs = await audioQuery.querySongs(
      sortType: null,
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
    );
    foundSongs = allSongs;
  }
}
