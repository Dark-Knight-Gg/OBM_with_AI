import 'package:flutter/material.dart';

import 'dialog_event.dart';
import 'dialog_ui.dart';

abstract class DialogHelper {
  static Future<void> show(
    BuildContext context,
    DialogEvent event,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: event.dismissible ?? false,
      builder: (BuildContext context) {
        if (event.dialogType == DialogType.customForm) {
          return DialogForm(event: event);
        }
        return DialogWithType(event: event);
      },
    );
  }
}
