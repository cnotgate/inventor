import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  const GenericButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.onLongPress,
      this.height,
      this.width,
      this.padding});

  final String text;
  final double? height;
  final double? width;
  final double? padding;
  final void Function() onPressed;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Set a uniform padding around the button
      padding: EdgeInsets.all(padding ?? 8),
      child: SizedBox(
        // SizedBox for determining button size
        height: height ?? 50,
        width: width ?? 120,
        child: ElevatedButton(
          onPressed: onPressed,
          onLongPress: onLongPress ?? () {},
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
