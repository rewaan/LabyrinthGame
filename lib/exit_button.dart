import 'package:flutter/material.dart';

/// Exit button used to exit game.
class ExitButton extends StatelessWidget {
  Function onClickedFunction;

  ExitButton(this.onClickedFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200, height: 60),
      child: ElevatedButton(
        onPressed: () {
          onClickedFunction();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: const Text("Exit"),
      ),
    );
  }
}
