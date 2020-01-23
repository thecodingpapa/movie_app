import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  double _page = 0;

  double get value => _page;
  set value(double page) {
    _page = page;
    notifyListeners();
  }
}

PageNotifier pageNotifier = PageNotifier();
