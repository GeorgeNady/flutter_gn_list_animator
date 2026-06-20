## 1.1.1

* **Feature**: Added `firstVisibleIndex` and `lastVisibleIndex` to `GnListAnimatorController` for real-time position tracking.
* **Feature**: Exposed `itemPositions` for advanced visibility analysis.

## 1.1.0

* **Feature**: Merged `ScrollController` and `ItemScrollController` into a single `GnListAnimatorController`.
* **Feature**: Added `onScrollUp` and `onScrollDown` callbacks to `GnListAnimator` for easy scroll direction detection.
* **Architecture**: Unified controller logic - `GnListAnimatorController` now extends `ScrollController`.
    * Supports standard `addListener`, `offset`, and `jumpTo`.
    * Adds `scrollToIndex` and `jumpToIndex`.
* **Refactor**: Widget automatically switches between `ListView` and `ScrollablePositionedList` based on the controller type.

## 1.0.9

* **Fix**: Restored `controller` (`ScrollController`) support for backward compatibility.
* **Feature**: Added conditional rendering: uses `ScrollablePositionedList` when `gnController` is provided, otherwise falls back to standard `ListView`.

## 1.0.8

* **Feature**: Integrated `scrollable_positioned_list` for index-based scrolling.
* **Feature**: Added `GnListAnimatorController` to manage scrolling and jumping to specific items.
* **Enhancement**: Added `clipBehavior` and `physics` parameters to `GnListAnimator`.

## 1.0.0

* Initial release of `gn_list_animator`.
* Basic staggered animations for list items.
* Support for custom animation durations and offsets.
