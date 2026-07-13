enum DialogActionType { close, confirm }

enum DialogType { none, success, warring, error, confirm, customForm }

class DialogEvent {
  final String? key;
  final DialogType dialogType;
  final String? title;
  final String? content;
  final Map<String,dynamic>? jsonForm;
  final Function(DialogActionType)? onActionCallback;
  final bool? dismissible;
  final String? confirmText;
  final String? closeText;
  final bool expandedActions;

  DialogEvent({
    this.key,
    this.dialogType = DialogType.none,
    this.jsonForm,
    this.title,
    this.content,
    this.onActionCallback,
    this.dismissible,
    this.confirmText,
    this.closeText,
    this.expandedActions = false,
  });

  DialogEvent.withType({
    required DialogType dialogType,
    String? title,
    String? content,
    Function(DialogActionType)? onActionCallback,
    bool? dismissible,
    bool expandedActions = false,
  }) : this(
          dialogType: dialogType,
          title: title,
          content: content,
          onActionCallback: onActionCallback,
          dismissible: dismissible,
          expandedActions: expandedActions,
        );

  String get icon => switch (dialogType) {
        DialogType.success => 'assets/images/ic_success_dialog.svg',
        DialogType.warring => 'assets/images/ic_warring_dialog.svg',
        DialogType.error => 'assets/images/ic_error_dialog.svg',
        DialogType.confirm => 'assets/images/ic_notification_dialog.svg',
        _ => 'assets/images/ic_notification_dialog.svg',
      };
}
