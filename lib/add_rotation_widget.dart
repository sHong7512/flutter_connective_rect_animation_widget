import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'connective_rect_animation.dart';

// connective_rect_animation.dart + 회전 애니메이션
class AddRotationWidget extends ConnectiveRectAnimationWidget {
  const AddRotationWidget({
    super.key,
    super.preModel,
    required super.mainModels,
    super.onTap,
    required super.child,
  });

  @override
  State<ConnectiveRectAnimationWidget> createState() => _DayBlueCharacterState();
}

class _DayBlueCharacterState extends ConnectiveRectAnimationWidgetState {
  final List<Animation<double>> rotateAnimations = [];
  final List<double> rotateOffset = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < controllers.length; i++) {
      Curve curve = Curves.linear;
      double offset = 2;
      if (i == 1) {
        curve = Curves.easeOutQuad;
      }
      rotateAnimations.add(CurvedAnimation(parent: controllers[i], curve: curve));
      rotateOffset.add(offset);
    }
  }

  @override
  Widget get curBody {
    return AnimatedBuilder(
      animation: rotateAnimations[curIndex],
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: rotateAnimations[curIndex].value * pi * 2,
          child: child,
        );
      },
      child: super.curBody,
    );
  }
}
