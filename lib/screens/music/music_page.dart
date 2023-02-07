import 'package:flutter/material.dart';
import 'package:playit/screens/music/music_page/albums/song_albums.dart';
import 'package:playit/screens/music/music_page/artist/song_artist.dart';
import 'package:playit/screens/music/music_page/recent/recent_page.dart';
import 'package:playit/screens/music/music_page/songs/songs_list_page.dart';
import 'package:playit/screens/music/search_song/search_song.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: SafeArea(
              child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          titleTextStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          // backgroundColor: Colors.black,
                          // systemOverlayStyle: const SystemUiOverlayStyle(
                          //   statusBarColor: Colors.black,
                          // ),
                          title: const Text("MUSIC"),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchSongPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ],
                          automaticallyImplyLeading: false,
                          pinned: true,
                          floating: true,
                          snap: true,
                          bottom: TabBar(indicatorColor: Colors.white, tabs: [
                            Tab(child: tabNames('Songs')),
                            Tab(child: tabNames('Artist')),
                            Tab(child: tabNames('Albums')),
                            Tab(child: tabNames('Recent')),
                          ]),
                        ),
                      ],
                  body: TabBarView(children: [
                    const SongList(),
                    SongArtisPage(),
                    SongAlbumsPage(),
                    const RecentlyPlayedWidget(),
                  ]))),
        ));
  }

  tabNames(String tabName) {
    return Text(
      tabName,
      style: const TextStyle(fontSize: 15),
    );
  }
}
