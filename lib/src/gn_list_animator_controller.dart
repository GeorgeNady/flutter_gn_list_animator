import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// A unified controller that combines [ScrollController] features with
/// [ItemScrollController] capabilities for index-based scrolling.
class GnListAnimatorController extends ScrollController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  late final ValueNotifier<int?> _firstVisibleIndexNotifier;
  late final ValueNotifier<int?> _lastVisibleIndexNotifier;

  GnListAnimatorController() {
    _firstVisibleIndexNotifier = ValueNotifier<int?>(null);
    _lastVisibleIndexNotifier = ValueNotifier<int?>(null);

    // Listen to position changes to update our notifiers
    itemPositionsListener.itemPositions.addListener(_updateIndices);
  }

  /// A listenable for the index of the first visible item.
  /// Use this with [ValueListenableBuilder] to update the UI in real-time.
  ValueListenable<int?> get firstVisibleIndexListenable => _firstVisibleIndexNotifier;

  /// A listenable for the index of the last visible item.
  /// Use this with [ValueListenableBuilder] to update the UI in real-time.
  ValueListenable<int?> get lastVisibleIndexListenable => _lastVisibleIndexNotifier;

  void _updateIndices() {
    final first = firstVisibleIndex;
    final last = lastVisibleIndex;

    if (_firstVisibleIndexNotifier.value != first) {
      _firstVisibleIndexNotifier.value = first;
    }
    if (_lastVisibleIndexNotifier.value != last) {
      _lastVisibleIndexNotifier.value = last;
    }
  }

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

  /// Returns the current visible item positions if using index-based scrolling.
  Iterable<ItemPosition> get itemPositions => itemPositionsListener.itemPositions.value;

  /// Returns the index of the first visible item if using index-based scrolling.
  int? get firstVisibleIndex {
    if (itemPositions.isEmpty) return null;
    return itemPositions
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemLeadingEdge < min.itemLeadingEdge ? position : min)
        .index;
  }

  /// Returns the index of the last visible item if using index-based scrolling.
  int? get lastVisibleIndex {
    if (itemPositions.isEmpty) return null;
    return itemPositions
        .where((ItemPosition position) => position.itemLeadingEdge < 1)
        .reduce((ItemPosition max, ItemPosition position) =>
            position.itemTrailingEdge > max.itemTrailingEdge ? position : max)
        .index;
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(_updateIndices);
    _firstVisibleIndexNotifier.dispose();
    _lastVisibleIndexNotifier.dispose();
    super.dispose();
  }
}
