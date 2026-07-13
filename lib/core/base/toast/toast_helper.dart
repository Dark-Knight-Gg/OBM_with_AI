import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'toast_event.dart';
import 'toast_widget.dart';

class ToastHelper {
  static void showToast(BuildContext context, ToastEvent event) {
    FToast()
      ..removeCustomToast()
      ..init(context)
      ..showToast(
        child: ToastWidget(event: event),
        toastDuration: event.duration,
        gravity: event.gravity,
      );
  }
}
