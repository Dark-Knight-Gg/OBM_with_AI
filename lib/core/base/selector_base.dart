import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:provider/provider.dart';
import 'base_provider.dart';


class SelectorBase<A> extends StatelessWidget {
  final Function(BuildContext context, dynamic repository)? onRepository;
  final Function(dynamic repository)? onRepositorySuccess;
  final Function(dynamic repository)? onRepositoryError;
  final Function(dynamic repository)? onRepositoryNoData;
  final BuildContext? contextParrent;
  final Function(dynamic repository)? onRepositoryLoading;
  final Function(BuildContext context)? onError401;
  final dynamic Function(BuildContext, A) selector;
  final String loaddingContent;
  const SelectorBase(
      {super.key,
      required this.selector,
      this.onRepositorySuccess,
      this.onRepositoryError,
      this.onRepositoryNoData,
      this.onRepository,
      this.onRepositoryLoading,
      this.contextParrent,
      this.loaddingContent = "",
      this.onError401});

  @override
  Widget build(BuildContext context) {
    return Selector<A, dynamic>(
      builder: (context, status, child) {
        if (onRepository != null) {
          return onRepository!(context, null) ?? Container();
        } else {
          return Container();
        }
      },
      selector: selector,
    );
  }
}

class ConsumerBase<S extends BaseService, P extends BaseProvider<S>>
    extends StatelessWidget {
  final Function(dynamic repository)? onRepository;
  late Function(dynamic repository)? onRepositorySuccess;
  final Function(dynamic repository)? onRepositoryError;
  final Function(dynamic repository)? onRepositoryNoData;
  final Function(dynamic repository)? onRepositoryLoading;
  final BuildContext? contextParent;
  final String loadingContent;

  ConsumerBase({
    super.key,
    this.onRepositorySuccess,
    this.onRepository,
    this.onRepositoryError,
    this.onRepositoryNoData,
    this.onRepositoryLoading,
    this.contextParent,
    this.loadingContent = "",
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<P>(builder: (context, P rep, child) {
      if (rep.isLoaded) {
        if (onRepositoryLoading == null) {
          ProgressLoad.dismissProgress(contextParent ?? context);
        }
        if (onRepositorySuccess != null) {
          return onRepositorySuccess!(rep) ?? Container();
        }
      } else if (rep.loadingFailed) {
        if (onRepositoryLoading == null) {
          ProgressLoad.dismissProgress(contextParent ?? context);
        }

        if (onRepositoryError != null) {
          return onRepositoryError!(rep) ?? Container();
        } else {
          return buildNotificationError(rep.error ?? "");
        }
      } else if (rep.isLoading) {
        if (onRepositoryLoading != null) {
          return onRepositoryLoading!(rep) ?? Container();
        } else {
          ProgressLoad.showProgress(contextParent ?? context, content: 'loading');
        }
      } else if (rep.noData) {
        if (onRepositoryLoading == null) {
          ProgressLoad.dismissProgress(contextParent ?? context);
        }
        if (onRepositoryNoData != null) {
          return onRepositoryNoData!(rep) ?? Container();
        } else {
          return Container(
              color: Colors.transparent,
              child: buildNotificationError('Không có dữ liệu'));
        }
      }
      if (onRepository != null) {
        return onRepository!(rep) ?? Container();
      } else {
        return Container();
      }
    });
  }
}

class ProgressLoad {
  /// Custom Notification
  static showProgress(BuildContext context, {String? content}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final progress = ProgressHUD.of(context);
      progress!.showWithText(content ?? 'loading');
    });
  }

  static dismissProgress(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final progress = ProgressHUD.of(context);
      progress!.dismiss();
    });
  }
}

Container buildNotificationError(String textError) {
  return Container(
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Center(
      child: Text(
        textError,
        textAlign: TextAlign.center,
      ),
    ),
  );
}