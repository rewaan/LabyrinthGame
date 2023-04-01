import 'package:flutter/material.dart';

/// Main menu button that starts Game.
class MenuButton extends StatelessWidget {
  Function onClickedFunction;

  MenuButton(this.onClickedFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200, height: 60),
      child: ElevatedButton(
        onPressed: () {
          onClickedFunction();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
