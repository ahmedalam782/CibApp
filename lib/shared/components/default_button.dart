import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  double? width;
  Color? backgroundColorButton;
  double radius;
  Widget child;
  Function() onPressed;
  double? elevation;
  double marginVertical;
  double? height;

  DefaultButton({
    required this.child,
    required this.onPressed,
    this.width,
    this.radius = 5,
    this.backgroundColorButton,
    this.elevation,
    this.marginVertical = 16,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: marginVertical,
      ),
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColorButton,
          ),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
