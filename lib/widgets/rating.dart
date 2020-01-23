import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final num rating;

  const Rating(
    this.rating, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Theme.of(context).secondaryHeaderColor,
              )),
          child: Text(
            'IMDB',
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(rating.toString(),
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).secondaryHeaderColor))
      ],
    );
  }
}
