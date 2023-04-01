import 'package:flutter/material.dart';

/// Side button class used to progress through game.
class SideButton extends StatelessWidget {
  Function onClickedFunction;

  String? direction;

  bool isDisabled = false;

  SideButton(this.direction, this.onClickedFunction, this.isDisabled,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 100, height: 60),
      child: ElevatedButton(
        onPressed: () {
          isDisabled ? null : onClickedFunction(direction);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? Colors.grey : Colors.pink,
        ),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
