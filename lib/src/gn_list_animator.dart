import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GnListAnimator extends StatefulWidget {
  final List<Widget> children;
  final Widget? separator;
  final int? durationInMillis;
  final double? verticalOffset;
  final double? horizontalOffset;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final Curve? curve;

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
  });

  @override
  _GnListAnimatorState createState() => _GnListAnimatorState();
}

class _GnListAnimatorState extends State<GnListAnimator> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        clipBehavior: Clip.none,
        padding: widget.padding,
        physics: const ScrollPhysics(),
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
