import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/data/movie_model.dart';
import 'package:movie_app/helpers/image_path_helper.dart';
import 'package:movie_app/pages/select_seat_page.dart';
import 'package:movie_app/widgets/genre.dart';
import 'package:movie_app/widgets/movie_title.dart';
import 'package:movie_app/widgets/rating.dart';

class DetailPage extends StatelessWidget {
  final MovieModel movieModel;

  const DetailPage(
    this.movieModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 700),
            pageBuilder: (_, __, ___) => SelectSeatPage(movieModel)));
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Hero(
                    tag: movieModel.posterPath,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.zero, bottom: Radius.circular(26)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius:
                                20.0, // has the effect of softening the shadow
                            spreadRadius:
                                5.0, // has the effect of extending the shadow
                            offset: Offset(
                              10.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.zero, bottom: Radius.circular(26)),
                        child: Image.network(
                          buildImagePath(movieModel.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Rating(movieModel.voteAverage),
                        MovieTitle(movieModel.originalTitle),
                        Genre(),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
//          body: GestureDetector(
//            onTap: () {
//              Navigator.of(context).push(MaterialPageRoute(
//                  builder: (_) => SelectSeatPage(movieModel)));
//            },
//            child: Container(
//              constraints: BoxConstraints.expand(),
//            ),
//          ),
          )
        ],
      ),
    );
  }
}
