import 'package:flutter/material.dart';
import 'package:movie_app/data/provider/movies_notifier.dart';
import 'package:movie_app/data/provider/page_notifier.dart';
import 'package:movie_app/pages/detail_page.dart';
import 'package:movie_app/pages/main_page.dart';
import 'package:movie_app/widgets/poster.dart';
import 'package:provider/provider.dart';

const double SCALE_FACTOR = 0.9;
const double VIEW_PORT_FACTOR = 0.6;

class PostPager extends StatefulWidget {
  @override
  _PostPagerState createState() => _PostPagerState();
}

class _PostPagerState extends State<PostPager> {
  static PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: VIEW_PORT_FACTOR)
      ..addListener(_onPageViewScrol);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageViewScrol() {
    pageNotifier.value = _pageController.page;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesNotifier>(
      builder: (context, movieNotifier, child) {
        return Transform.scale(
          scale: 12 / 10,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return Consumer<PageNotifier>(
                builder: (context, page, child) {
                  double scale = 1 +
                      (SCALE_FACTOR - 1) *
                          (page.value - index.toDouble()).abs();
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 700),
                          pageBuilder: (_, __, ___) =>
                              DetailPage(movieNotifier.movies[index])));
                    },
                    child: Hero(
                      tag: movieNotifier.movies[index].posterPath,
                      child: Poster(
                        scale: scale,
                        img: movieNotifier.movies[index].posterPath,
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: movieNotifier.movies.length,
          ),
        );
      },
    );
  }
}
