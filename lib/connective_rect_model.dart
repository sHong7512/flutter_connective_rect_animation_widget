import 'package:flutter/material.dart';

// ConnectiveRectAnimationWidget 과 함께 사용
// 아래 static들은 그냥 예시
class ConnectiveRectModel {
  ConnectiveRectModel({
    required this.relativeRectTween,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.linear,
  });

  final RelativeRectTween relativeRectTween;
  final Duration duration;
  final Curve curve;

  static RelativeRect _leftTop(double standardWidth, double standardHeight) =>
      RelativeRect.fromLTRB(0, 0, standardWidth / 1.5, standardHeight / 1.5);

  static RelativeRect _rightTop(double standardWidth, double standardHeight) =>
      RelativeRect.fromLTRB(standardWidth / 1.5, 0, 0, standardHeight / 1.5);

  static RelativeRect _leftBottom(double standardWidth, double standardHeight) =>
      RelativeRect.fromLTRB(0, standardHeight / 1.5, standardWidth / 1.5, 0);

  static RelativeRect _rightBottom(double standardWidth, double standardHeight) =>
      RelativeRect.fromLTRB(standardWidth / 1.5, standardHeight / 1.5, 0, 0);

  static RelativeRect _center(double standardWidth, double standardHeight) => RelativeRect.fromLTRB(
      standardWidth / 2, standardHeight / 2, standardWidth / 2, standardHeight / 2);

  static ConnectiveRectModel _first(double standardWidth, double standardHeight) =>
      ConnectiveRectModel(
        relativeRectTween: RelativeRectTween(
          begin: _leftTop(standardWidth, standardHeight),
          end: _rightTop(standardWidth, standardHeight),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutBack,
      );

  static ConnectiveRectModel _second(double standardWidth, double standardHeight) =>
      ConnectiveRectModel(
        relativeRectTween: RelativeRectTween(
          begin: _rightTop(standardWidth, standardHeight),
          end: _rightBottom(standardWidth, standardHeight),
        ),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
      );

  static ConnectiveRectModel _third(double standardWidth, double standardHeight) =>
      ConnectiveRectModel(
        relativeRectTween: RelativeRectTween(
          begin: _rightBottom(standardWidth, standardHeight),
          end: _leftBottom(standardWidth, standardHeight),
        ),
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOutBack,
      );

  static ConnectiveRectModel _forth(double standardWidth, double standardHeight) =>
      ConnectiveRectModel(
        relativeRectTween: RelativeRectTween(
          begin: _leftBottom(standardWidth, standardHeight),
          end: _leftTop(standardWidth, standardHeight),
        ),
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeIn,
      );

  static ConnectiveRectModel preWorkGreen(double standardWidth, double standardHeight) =>
      ConnectiveRectModel(
        relativeRectTween: RelativeRectTween(
          begin: _center(standardWidth, standardHeight),
          end: _leftTop(standardWidth, standardHeight),
        ),
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeOutBack,
      );

  static ConnectiveRectModel preWorkRed(double standardWidth, double standardHeight) =>
      ConnectiveRectModel(
        relativeRectTween: RelativeRectTween(
          begin: _center(standardWidth, standardHeight),
          end: _rightTop(standardWidth, standardHeight),
        ),
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeOutBack,
      );

  static greenModels(double standardWidth, double standardHeight) => <ConnectiveRectModel>[
        _first(standardWidth, standardHeight),
        _second(standardWidth, standardHeight),
        _third(standardWidth, standardHeight),
        _forth(standardWidth, standardHeight),
      ];

  static redModels(double standardWidth, double standardHeight) => <ConnectiveRectModel>[
        _second(standardWidth, standardHeight),
        _third(standardWidth, standardHeight),
        _forth(standardWidth, standardHeight),
        _first(standardWidth, standardHeight),
      ];
}
