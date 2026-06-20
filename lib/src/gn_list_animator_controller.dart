import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// A unified controller that combines [ScrollController] features with
/// [ItemScrollController] capabilities for index-based scrolling.
class GnListAnimatorController extends ScrollController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  /// Scrolls to the item at [index].
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

  /// Jumps to the item at [index].
  void jumpToIndex(int index, {double alignment = 0.0}) {
    if (itemScrollController.isAttached) {
      itemScrollController.jumpTo(
        index: index,
        alignment: alignment,
      );
    }
  }

  /// Returns true if the index-based controller is attached.
  bool get isIndexControllerAttached => itemScrollController.isAttached;
}
