import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zapbuzz/presentation/utils/const/const.dart';

class LoadingAnimationStaggeredDotsWave extends StatelessWidget {
  const LoadingAnimationStaggeredDotsWave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: primaryKcolor,
        size: 40,
      ),
    );
  }
}

class ThreeDotLoadingAnimation extends StatelessWidget {
  const ThreeDotLoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.threeRotatingDots(
            color: primaryKcolor, size: 30));
  }
}
