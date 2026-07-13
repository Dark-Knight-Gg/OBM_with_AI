import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { normal, success, error, warning }

class ToastEvent {
  final String message;
  final ToastType type;
  final Duration duration;
  final int? maxLines;
  final ToastGravity? gravity;

  ToastEvent(
      {required this.message,
      required this.type,
      this.duration = const Duration(seconds: 2),
      this.maxLines,
      this.gravity});

  @override
  String toString() {
    return 'ToastEvent{message: $message, type: $type}';
  }
}
