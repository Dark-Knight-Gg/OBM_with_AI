import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/core_text.dart';
import 'toast_event.dart';

class ToastWidget extends StatelessWidget {
  final ToastEvent event;

  const ToastWidget({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor()),
        color: backgroundColor(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          _buildIcon(),
          Expanded(
            child: OneUiText.textWidget(
              title: event.message,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLines: event.maxLines ?? 50,
              overflow: TextOverflow.ellipsis,
              color: textColor(),
            ),
          ),
          if (event.type != ToastType.normal)
            GestureDetector(
              onTap: () => FToast().removeCustomToast(),
              child: SvgPicture.string(
                """<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 15 15 5m0 10L5 5" stroke="#696969" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>""",
              ),
            )
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return switch (event.type) {
      ToastType.success => SvgPicture.string(
          """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="10" fill="#fff"/><path d="M12 2C6.49 2 2 6.49 2 12s4.49 10 10 10 10-4.49 10-10S17.51 2 12 2m4.78 7.7-5.67 5.67a.75.75 0 0 1-1.06 0l-2.83-2.83a.754.754 0 0 1 0-1.06c.29-.29.77-.29 1.06 0l2.3 2.3 5.14-5.14c.29-.29.77-.29 1.06 0s.29.76 0 1.06" fill="#178237"/></svg>""",
        ),
      ToastType.error => SvgPicture.string(
          """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="10" fill="#fff"/><path d="M12 2C6.49 2 2 6.49 2 12s4.49 10 10 10 10-4.49 10-10S17.51 2 12 2m3.36 12.3c.29.29.29.77 0 1.06-.15.15-.34.22-.53.22s-.38-.07-.53-.22l-2.3-2.3-2.3 2.3c-.15.15-.34.22-.53.22s-.38-.07-.53-.22a.754.754 0 0 1 0-1.06l2.3-2.3-2.3-2.3a.754.754 0 0 1 0-1.06c.29-.29.77-.29 1.06 0l2.3 2.3 2.3-2.3c.29-.29.77-.29 1.06 0s.29.77 0 1.06l-2.3 2.3z" fill="#C10800"/></svg>""",
        ),
      ToastType.warning => SvgPicture.string(
          """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="10" fill="#FF9100"/><rect x="11.25" y="7" width="1.5" height="7" rx=".75" fill="#fff"/><circle cx="12" cy="16.5" r="1" fill="#fff"/></svg>""",
        ),
      _ => SizedBox.shrink(),
    };
  }

  Color? backgroundColor() {
    return switch (event.type) {
      ToastType.success => Color(0xFFF0FCF3),
      ToastType.error => Color(0xFFFFF0EF),
      ToastType.warning => Color(0xFFFFF5E9),
      _ => Colors.black,
    };
  }

  Color borderColor() {
    return switch (event.type) {
      ToastType.success => Color(0xFF178237),
      ToastType.error => Color(0xFFC10800),
      ToastType.warning => Color(0xFFFF9100),
      _ => Colors.transparent,
    };
  }

  Color textColor() {
    return switch (event.type) {
      ToastType.normal => Colors.white,
      _ => Color(0xFF2f2f2f),
    };
  }
}
