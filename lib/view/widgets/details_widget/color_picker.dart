import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final bool outerBorder;
  final Color colors;
  const ColorPicker({Key? key, required this.outerBorder, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: outerBorder ? Border.all(color: colors,width: 1.0): null,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors,
        ),
      ),
    );
  }
}
