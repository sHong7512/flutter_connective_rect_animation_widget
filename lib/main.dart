import 'dart:developer';

import 'package:connective_rect_animation_widget/add_rotation_widget.dart';
import 'package:flutter/material.dart';

import 'connective_rect_animation.dart';
import 'connective_rect_model.dart';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final greenController = CrawController();
  final redController = CrawController();

  @override
  Widget build(BuildContext context) {
    final standardWidth = MediaQuery.of(context).size.width;
    final standardHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ConnectiveRectAnimationWidget(
              preModel: ConnectiveRectModel.preWorkGreen(standardWidth, standardHeight),
              mainModels: ConnectiveRectModel.greenModels(standardWidth, standardHeight),
              child: _box(Colors.green),
              onTap: () {
                log('sHong :: Blue Tap!!');
              },
              crawController: greenController,
            ),
            AddRotationWidget(
              preModel: ConnectiveRectModel.preWorkRed(standardWidth, standardHeight),
              mainModels: ConnectiveRectModel.redModels(standardWidth, standardHeight),
              child: _box(Colors.red),
              onTap: () {
                log('sHong :: Red Tap!!');
              },
              crawController: redController,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  greenController.forwardMain(0);
                  redController.forwardMain(0);
                },
                child: const Text('Main Animation Start'),
              ),
            )
          ],
        ),
      ),
    );
  }

  _box(Color color) => Container(
        color: color,
        child: const Center(
          child: Text('Tap!'),
        ),
      );
}
