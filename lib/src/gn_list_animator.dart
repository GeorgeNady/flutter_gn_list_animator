import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GnListAnimator extends StatefulWidget {
  final List<Widget> children;
  final int? durationInMillis;
  final double? verticalOffset;
  final double? horizontalOffset;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Curve? curve;

  const GnListAnimator({
    super.key,
    required this.children,
    this.durationInMillis,
    this.verticalOffset,
    this.horizontalOffset,
    this.shrinkWrap = true,
    this.padding,
    this.curve,
  });

  @override
  _GnListAnimatorState createState() => _GnListAnimatorState();
}

class _GnListAnimatorState extends State<GnListAnimator> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        clipBehavior: Clip.none,
        padding: widget.padding,
        physics: const ScrollPhysics(),
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.children.length,
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
      ),
    );
  }
}
