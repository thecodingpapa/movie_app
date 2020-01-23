import 'package:flutter/material.dart';
import 'package:movie_app/helpers/image_path_helper.dart';

class Poster extends StatelessWidget {
  const Poster({
    Key key,
    @required this.scale,
    @required this.img,
  }) : super(key: key);

  final double scale;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Transform.scale(
        scale: scale,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.zero, bottom: Radius.circular(26)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 16.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    0, // horizontal, move right 10
                    10.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(buildImagePath(img)))),
      ),
    );
  }
}
