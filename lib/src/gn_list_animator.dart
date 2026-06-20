import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'gn_list_animator_controller.dart';

class GnListAnimator extends StatefulWidget {
  final List<Widget> children;
  final Widget? separator;
  final int? durationInMillis;
  final double? verticalOffset;
  final double? horizontalOffset;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final Axis scrollDirection;
  final Curve? curve;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Clip clipBehavior;

  /// Callback triggered when the user scrolls down (towards the end of the list).
  final VoidCallback? onScrollReverse;

  /// Callback triggered when the user scrolls up (towards the start of the list).
  final VoidCallback? onScrollForward;

  const GnListAnimator({
    super.key,
    required this.children,
    this.separator,
    this.durationInMillis,
    this.verticalOffset,
    this.horizontalOffset,
    this.shrinkWrap = true,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.curve,
    this.controller,
    this.physics,
    this.clipBehavior = Clip.none,
    this.onScrollReverse,
    this.onScrollForward,
  });

  @override
  _GnListAnimatorState createState() => _GnListAnimatorState();
}

class _GnListAnimatorState extends State<GnListAnimator> {
  @override
  Widget build(BuildContext context) {
    final bool useIndexScroll = widget.controller is GnListAnimatorController;

    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.reverse) {
          widget.onScrollReverse?.call();
        } else if (notification.direction == ScrollDirection.forward) {
          widget.onScrollForward?.call();
        }
        return false;
      },
      child: AnimationLimiter(
        child: useIndexScroll
            ? _buildPositionedList(widget.controller as GnListAnimatorController)
            : _buildListView(),
      ),
    );
  }

  Widget _buildPositionedList(GnListAnimatorController gnController) {
    return ScrollablePositionedList.separated(
      itemScrollController: gnController.itemScrollController,
      itemPositionsListener: gnController.itemPositionsListener,
      padding: widget.padding,
      physics: widget.physics ?? const ScrollPhysics(),
      shrinkWrap: widget.shrinkWrap,
      itemCount: widget.children.length,
      scrollDirection: widget.scrollDirection,
      itemBuilder: (_, index) => _buildAnimatedItem(index),
      separatorBuilder: (_, index) => widget.separator ?? const SizedBox(),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      controller: widget.controller,
      padding: widget.padding,
      physics: widget.physics ?? const ScrollPhysics(),
      shrinkWrap: widget.shrinkWrap,
      itemCount: widget.children.length,
      scrollDirection: widget.scrollDirection,
      clipBehavior: widget.clipBehavior,
      itemBuilder: (_, index) => _buildAnimatedItem(index),
      separatorBuilder: (_, index) => widget.separator ?? const SizedBox(),
    );
  }

  Widget _buildAnimatedItem(int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: Duration(milliseconds: widget.durationInMillis ?? 100),
      child: SlideAnimation(
        curve: widget.curve ?? Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        verticalOffset: widget.verticalOffset ?? 50.0,
        horizontalOffset: widget.horizontalOffset,
        child: FadeInAnimation(
          child: widget.children[index],
        ),
      ),
    );
  }
}
