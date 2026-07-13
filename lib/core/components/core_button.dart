// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CoreButton extends StatelessWidget {
  CoreButton({
    super.key,
    this.text = "",
    required this.onPress,
    this.backgroundColor = Colors.blueAccent,
    this.colorBorder = Colors.transparent,
    this.width,
    this.height,
    this.isLeftIcon = false,
    this.isRightIcon = false,
    this.shadowColor = Colors.transparent,
    this.iconRight = Icons.abc,
    this.sizeIcon = 15,
    this.alignmentText = Alignment.center,
    this.styleText,
    this.colorIcon = Colors.white,
    this.textColor = Colors.white,
    this.iconLeft,
    this.marginRightIcon,
    this.marginLeftIcon = 8,
    this.maxLineTextButton,
    this.padding = const EdgeInsets.all(10.0),
    this.borderRadius,
    this.borderWidth = 1.0,
    this.margin = const EdgeInsets.all(0),
    this.elevation = const WidgetStatePropertyAll(0),
  });
  late String text;
  final Function() onPress;
  final Color backgroundColor;
  late Color colorBorder;
  final double? width;
  final double? height;
  final double? marginRightIcon;
  final double marginLeftIcon;
  late Color shadowColor;
  late double borderWidth;
  final Color? colorIcon;
  final Color? textColor;
  late IconData iconRight;
  final IconData? iconLeft;
  final double sizeIcon;
  late Alignment alignmentText;
  final TextStyle? styleText;
  final bool isLeftIcon;
  final int? maxLineTextButton;
  final bool isRightIcon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final WidgetStateProperty<double?>? elevation;
  late BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: elevation,
          padding: WidgetStateProperty.all<EdgeInsets>(padding ?? EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(4), side: BorderSide(color: colorBorder, width: borderWidth)),
          ),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
                visible: isLeftIcon,
                child: Container(
                  padding: EdgeInsets.only(right: marginLeftIcon),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    iconLeft,
                    color: colorIcon,
                    size: sizeIcon,
                  ),
                )),
            Flexible(
              child: Text(
                text,
                maxLines: maxLineTextButton ?? 1,
                style: styleText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Visibility(
                visible: isRightIcon,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: marginRightIcon ?? 2),
                  child: Icon(
                    iconRight,
                    size: sizeIcon,
                    color: colorIcon,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
