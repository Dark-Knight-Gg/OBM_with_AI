import 'package:flutter/material.dart';
import '../../components/core_button.dart';
import '../../components/image.dart';
import 'dialog_event.dart';

class DialogWithType extends StatelessWidget {
  final DialogEvent event;

  const DialogWithType({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 280, maxWidth: 400),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xff595959),
            offset: const Offset(0, 8),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          svgAsset(
            event.icon,
            package: 'modulevnelife',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 20),
          if (event.title != null) ...[
            Text(
              event.title ?? '',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xff1b1b17),
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (event.content != null)
            Text(
              event.content ?? '',
              maxLines: 5,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff696969),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          const SizedBox(height: 22),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildActions(context, event),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context, DialogEvent event) {
    final result = <Widget>[];
    result.add(CoreButton(
      width: event.expandedActions ? null : 120,
      text: event.closeText ?? "Đóng",
      styleText: TextStyle(
        color: event.dialogType == DialogType.confirm
            ? Color(0xFFC10800)
            : Color(0xffffffff),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      onPress: () {
        Navigator.of(context).pop();
        if (event.onActionCallback != null) {
          event.onActionCallback!(DialogActionType.close);
        }
      },
      borderRadius: BorderRadius.all(Radius.circular(4)),
      backgroundColor: event.dialogType == DialogType.confirm
          ? Colors.white
          : Color(0xFFC10800),
      borderWidth: event.dialogType == DialogType.confirm ? 1.5 : 0,
      colorBorder: Color(0xFFC10800),
      padding: event.expandedActions
          ? EdgeInsets.zero
          : const EdgeInsets.only(left: 24, right: 24),
    ).wrapByExpanded(event.expandedActions));

    if (event.dialogType == DialogType.confirm) {
      result.add(const SizedBox(width: 16));
      result.add(CoreButton(
        width: event.expandedActions ? null : 120,
        text: event.confirmText ?? "Xác nhận",
        styleText: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        onPress: () {
          Navigator.of(context).pop();
          if (event.onActionCallback != null) {
            event.onActionCallback!(DialogActionType.confirm);
          }
        },
        borderRadius: BorderRadius.all(Radius.circular(4)),
        backgroundColor: Color(0xFFC10800),
        padding: event.expandedActions
            ? EdgeInsets.zero
            : const EdgeInsets.only(left: 24, right: 24),
      ).wrapByExpanded(event.expandedActions));
    }
    return result;
  }
}

class DialogForm extends StatefulWidget {
  final DialogEvent event;

  const DialogForm({
    super.key,
    required this.event,
  });

  @override
  DialogModuleState createState() => DialogModuleState();
}

class DialogModuleState extends State<DialogForm> {
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(context) {
    return SizedBox();
  }
}

extension _WidgetExts on Widget {
  Widget wrapByExpanded(bool expanded) {
    if (expanded) {
      return Expanded(child: this);
    }
    return this;
  }
}
