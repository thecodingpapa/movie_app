import 'package:flutter/material.dart';
import 'package:movie_app/data/movie_model.dart';
import 'package:movie_app/data/provider/movies_notifier.dart';
import 'package:movie_app/data/provider/page_notifier.dart';
import 'package:movie_app/repository/movie_db_provider.dart';
import 'package:movie_app/widgets/genre.dart';
import 'package:movie_app/widgets/movie_title.dart';
import 'package:movie_app/widgets/post_pager.dart';
import 'package:movie_app/widgets/rating.dart';
import 'package:provider/provider.dart';

const double side_gap = 16;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int _selectedIndex = 0;
  static Size size;

  static double searchTop = side_gap;
  static double nowPlayingTop = searchTop + 66 + side_gap;
  static double posterTop = nowPlayingTop + 72;
  static double ratingTop = size.width + posterTop + side_gap;
  static double titleTop = ratingTop + 18 + 8;
  static double genreTop = titleTop + 26 + 8;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<BottomNavigationBarItem> _bnbItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      title: Text('Business'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      title: Text('School'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    movieDBProvider.discoverMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void currentPage(int currentPage) {}

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoviesNotifier>.value(value: moviesNotifier),
        ChangeNotifierProvider<PageNotifier>.value(value: pageNotifier),
      ],
      child: ChangeNotifierProvider<MoviesNotifier>.value(
        value: moviesNotifier,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          bottomNavigationBar: BottomNavigationBar(
            items: _bnbItems,
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).accentColor,
            onTap: _onBottomItemTapped,
          ),
          body: SafeArea(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: Consumer2<MoviesNotifier, PageNotifier>(
                builder: (context, movieNotifier, pageNotifier, child) {
                  if (movieNotifier.movies.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  MovieModel movieModel =
                      movieNotifier.movies[pageNotifier.value.floor()];
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        top: searchTop,
                        left: side_gap,
                        right: side_gap,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: TextField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                hintText: 'Search',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ),
                      Positioned(
                        top: nowPlayingTop,
                        left: side_gap,
                        height: 40,
                        child: FittedBox(
                          child: Text(
                            'Now Playing',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ratingTop,
                        left: side_gap,
                        child: Rating(movieModel.voteAverage),
                      ),
                      Positioned(
                          top: titleTop,
                          left: side_gap,
                          child: MovieTitle(movieModel.originalTitle)),
                      Positioned(top: genreTop, left: side_gap, child: Genre()),
                      Positioned(
                          top: posterTop,
                          left: 0,
                          right: 0,
                          height: size.width,
//                  child:
//                      PostPager(page: _page, pageController: _pageController)),
                          child: PostPager()),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
