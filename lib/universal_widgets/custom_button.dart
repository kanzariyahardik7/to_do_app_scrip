import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final String text;
  final VoidCallback onTap;
  final double borderRadious;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.height = 50,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.textSize = 16,
    this.borderRadious = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadious,
            ), // rounded corners
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
