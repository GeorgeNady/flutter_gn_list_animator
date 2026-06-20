import 'package:flutter/material.dart';
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
  final GnListAnimatorController? gnController;
  final ScrollPhysics? physics;
  final Clip clipBehavior;

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
    this.gnController,
    this.physics,
    this.clipBehavior = Clip.none,
  });

  @override
  _GnListAnimatorState createState() => _GnListAnimatorState();
}

class _GnListAnimatorState extends State<GnListAnimator> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ScrollablePositionedList.separated(
        itemScrollController: widget.gnController?.itemScrollController,
        itemPositionsListener: widget.gnController?.itemPositionsListener,
        padding: widget.padding,
        physics: widget.physics ?? const ScrollPhysics(),
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.children.length,
        scrollDirection: widget.scrollDirection,
        itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
          position: index,
          delay: Duration(milliseconds: widget.durationInMillis ?? 100),
          child: SlideAnimation(
            curve: widget.curve ?? Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            verticalOffset: widget.verticalOffset ?? 50.0,
            child: FadeInAnimation(
              child: widget.children[index],
            ),
          ),
        ),
        separatorBuilder: (_, index) => widget.separator ?? const SizedBox(),
      ),
    );
  }
}
