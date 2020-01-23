import 'package:flutter/material.dart';

class Genre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Action, Crime, Thriller',
        style: TextStyle(
            color: Theme.of(context).secondaryHeaderColor,
            fontWeight: FontWeight.w700));
  }
}
