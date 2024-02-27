import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListAnimator extends StatefulWidget {
  final List<Widget> data;
  final int? durationInMillis;
  final double? verticalOffset;
  final double? horizontalOffset;
  final EdgeInsetsGeometry? padding;
  final Curve? curve;

  const ListAnimator({
    super.key,
    required this.data,
    this.durationInMillis,
    this.verticalOffset,
    this.horizontalOffset,
    this.padding,
    this.curve,
  });

  @override
  _ListAnimatorState createState() => _ListAnimatorState();
}

class _ListAnimatorState extends State<ListAnimator> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        clipBehavior: Clip.none,
        padding: widget.padding,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data.length,
        itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
          position: index,
          delay: Duration(milliseconds: widget.durationInMillis ?? 100),
          child: SlideAnimation(
            curve: widget.curve ?? Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            verticalOffset: widget.verticalOffset ?? 50.0,
            child: FadeInAnimation(
              child: widget.data[index],
            ),
          ),
        ),
      ),
    );
  }
}
