import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class GnListAnimatorController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  void scrollToIndex(
    int index, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
    double alignment = 0.0,
  }) {
    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
        index: index,
        duration: duration,
        curve: curve,
        alignment: alignment,
      );
    }
  }

  void jumpToIndex(int index, {double alignment = 0.0}) {
    if (itemScrollController.isAttached) {
      itemScrollController.jumpTo(
        index: index,
        alignment: alignment,
      );
    }
  }
}
