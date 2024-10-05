// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../globals.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onPress,
    Color? color,
    Color? iconColor,
    this.size ,
    this.text = "",
    Color? textColor,
    this.icon,
    this.pressedColor,
    this.disableColor,
    this.borderRadius = 10,
  }) {
    this.textColor = (textColor!= null)?textColor:AppColors.mainTextColor;
    this.iconColor = (iconColor!=null)?this.iconColor:textColor;
    this.color = (color!=null)?color:AppColors.buttonColors.color;
    pressedColor = AppColors.buttonColors.pressedColor;
    disableColor = AppColors.buttonColors.disableColor;
  }

  VoidCallback onPress;
  Size? size;
  String text;
  Color? textColor;
  Widget? icon;
  Color? iconColor;
  Color? color;
  Color? pressedColor;
  Color? disableColor;
  double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width,
      height: size?.height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return pressedColor!;
              } else if (states.contains(WidgetState.disabled)) {
                return disableColor!;
              }
              return color!;
            }),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(color: textColor)),
            if(icon != null)...[const SizedBox(width: 5,),icon!,],
          ],
        ),
      ),
    );

  }
}
