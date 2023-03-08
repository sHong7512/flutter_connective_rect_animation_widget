import 'package:connective_rect_animation_widget/add_rotation_widget.dart';
import 'package:flutter/material.dart';

import 'connective_rect_animation.dart';
import 'connective_rect_model.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ConnectiveRectAnimationWidget(
              mainModels: ConnectiveRectModel.greenModels(
                  MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              child: _box(Colors.green),
              onTap: () {
                print('sHong :: Blue Tap!!');
              },
            ),
            AddRotationWidget(
              mainModels: ConnectiveRectModel.redModels(
                  MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              child: _box(Colors.red),
              onTap: () {
                print('sHong :: Red Tap!!');
              },
            ),
          ],
        ),
      ),
    );
  }

  _box(Color color) => Container(
        color: color,
        child: const Center(
          child: Text('Click!'),
        ),
      );
}
