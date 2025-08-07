import 'package:flutter/material.dart';

class ScrollPosProvider extends ChangeNotifier {
  double _scrollOffset = 0.0;

  double get scrollOffset => _scrollOffset;

  void updateScrollOffset(double offset) {
    _scrollOffset = offset;
  }
}