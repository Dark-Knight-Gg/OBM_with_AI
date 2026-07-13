import 'dart:ui';

import 'package:flutter_svg/svg.dart';

SvgPicture svgAsset(String name,
    {double? width,
    double? height,
    Color? color,
    String? package,
    bool active = true}) {
  return SvgPicture.asset(
    name,
    package: package,
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
        active ? (color ?? const Color(0x00000000)) : const Color(0xa6f3f3f3),
        BlendMode.srcATop),
  );
}
