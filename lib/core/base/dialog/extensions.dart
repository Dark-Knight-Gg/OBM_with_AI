import 'package:flutter/material.dart';

import 'dialog_event.dart';

// extension DialogActionExt on DialogAction {
  // Widget toWidget(BuildContext context) {
  //   switch (type) {
  //     case DialogActionType.close:
  //       return _buildCloseAction(context);
  //     case DialogActionType.confirm:
  //       return _buildConfirmAction(context);
  //   }
  // }
  //
  // Widget _buildCloseAction(BuildContext context) {
  //   return BaseButton(
  //     text: text,
  //     styleText: TextStyle(color: Color(0xFFC10800)),
  //     onPress: () {
  //       Navigator.of(context).pop();
  //       onTap?.call();
  //     },
  //     borderRadius: BorderRadius.all(Radius.circular(6)),
  //     backgroundColor: Colors.white,
  //     borderWidth: 1,
  //     colorBorder: Colors.red,
  //     padding: const EdgeInsets.only(left: 24, right: 24),
  //   );
  // }
  //
  // Widget _buildConfirmAction(BuildContext context) {
  //   return OutlinedButton(
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //       onTap?.call();
  //     },
  //     style: OutlinedButton.styleFrom(
  //       minimumSize: Size(80, 32),
  //       padding: EdgeInsets.symmetric(horizontal: 12),
  //       side: BorderSide(color: ColorApp.brand),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(6),
  //       ),
  //     ),
  //     child: Text(
  //       text,
  //     ),
  //   );
  // }
  //
  // Widget buttonAction(BuildContext context) {
  //   return BaseButton(
  //     text: text,
  //     onPress: () {
  //       Navigator.pop(context);
  //       onTap?.call();
  //     },
  //     backgroundColor: Color(0xC10800),
  //     padding: const EdgeInsets.only(left: 48, right: 48),
  //   );
  // }
// }
