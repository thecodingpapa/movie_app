import 'package:flutter/material.dart';

class MovieTitle extends StatelessWidget {
  const MovieTitle(
    this.movieTitle, {
    Key key,
  }) : super(key: key);

  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    return Text(movieTitle,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
  }
}
