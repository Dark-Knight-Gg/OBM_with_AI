import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_app.dart';

class FontConstants {
  static const String fontFamily = "Inter";
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class OneUiText {
  /// TextWidget
  static Widget textWidget({
    required String title,
    FontStyle fontStyle = FontStyle.normal,
    double? fontSize = 12,
    Color? color = ColorApp.textDefault,
    FontWeight? fontWeight = FontWeight.w400,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
  }) {
    return Text(
      title,
      style: textStyle(fontSize ?? 14.0, fontWeight ?? FontWeight.w400, color, fontStyle),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.visible,
      textAlign: textAlign,
    );
  }

  static TextSpan textSpanWidget({
    required String title,
    FontStyle fontStyle = FontStyle.normal,
    double? fontSize = 12,
    Color? color = ColorApp.textDefault,
    FontWeight? fontWeight = FontWeight.w400,
  }) {
    return TextSpan(text: title, style: textStyle(fontSize ?? 14.0, fontWeight ?? FontWeight.w400, color, fontStyle));
  }

  /// TextWidgetDefault
  static Widget textWidgetDefault(String title) {
    return Text(title, style: textStyleThem());
  }

  static TextStyle textStyleThem() {
    return const TextStyle(color: ColorApp.textDefault, fontSize: 14);
  }

  static TextStyle textStyle(
    double fontSize,
    FontWeight fontWeight,
    Color? color, [
    FontStyle fontStyle = FontStyle.normal,
  ]) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? ColorApp.textDefault,
      fontStyle: fontStyle,
    );
  }

  // style text Button
  static TextStyle textStyleButton(Color? color) {
    return TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w500);
  }

  static TextStyle common = const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: ColorApp.textDefault);
  static TextStyle focusTextStyle = common.copyWith(color: ColorApp.color002060);

  static TextStyle labelTextStyle = common.copyWith(color: ColorApp.textDefault, fontWeight: FontWeight.bold);

  static TextStyle labelTextRequiredStyle = common.copyWith(color: ColorApp.colorFF0000, fontWeight: FontWeight.bold);

  static TextStyle textFieldStyle = common.copyWith(color: ColorApp.textDefault);

  static TextStyle textFieldErrorStyle = common.copyWith(color: ColorApp.colorFF0000);

  static TextStyle disableTextStyle = common.copyWith(color: ColorApp.color7D8798);

  static TextStyle hintTextStyle = common.copyWith(color: ColorApp.colorADB5BE, fontWeight: FontWeight.w400);

  TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(fontSize: fontSize, fontFamily: FontConstants.fontFamily, color: color, fontWeight: fontWeight);
  }

  // regular style

  TextStyle getRegularStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? 12, FontWeightManager.regular, color);
  }

  // medium style

  TextStyle getMediumStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? 12, FontWeightManager.medium, color);
  }

  // medium style

  TextStyle getLightStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? 12, FontWeightManager.light, color);
  }

  // bold style

  TextStyle getBoldStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? 12, FontWeightManager.bold, color);
  }

  // semibold style

  TextStyle getSemiBoldStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? 12, FontWeightManager.semiBold, color);
  }
}
