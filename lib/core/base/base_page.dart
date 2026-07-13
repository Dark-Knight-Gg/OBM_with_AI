import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/progress/progress_event.dart';
import 'package:obm_gen_with_ai/core/base/progress/progress_helper.dart';
import 'package:obm_gen_with_ai/core/base/selector_base.dart';
import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/base/navigation/navigate_event.dart';
import 'package:obm_gen_with_ai/core/base/navigation/navigator_helper.dart' as nav_helper ;
import 'package:obm_gen_with_ai/core/base/toast/toast_helper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_provider.dart';
import 'dialog/dialog_event.dart';
import 'dialog/dialog_helper.dart';

enum PageAction {
  showLoading,
  hideLoading,
  showError,
  showNoData,
  showLoaded,
  showDialog,
  showBottomSheet,
  showToast,
  changeFormPage,
}

mixin BasePageMixin<S extends BaseService, P extends BaseProvider<S>> {
  P pageProvider(BuildContext context) => context.read<P>();
  final StreamController<dynamic> eventStream = StreamController<dynamic>.broadcast();


  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget? buildDrawer(BuildContext context) => null;

  Widget buildRoot(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: ConsumerBase<S, P>(
        onRepositoryLoading: (rep) {
          return const Center(child: CircularProgressIndicator());
        },
        onRepositorySuccess: (rep) {
          return buildBody(context);
        },
        onRepository: (rep) {
          return buildBody(context);
        },
      ),
    );
  }

  void initEventListener(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      pageProvider(context).setEventStream(eventStream);
      eventStream.stream.listen((event) {
        if (event is NavigateEvent) {
          nav_helper.NavigatorHelper.navigate(event, (response) {
            pageProvider(context).onEventResult(event, response);
          });
          return;
        }
        if (event is DialogEvent) {
          DialogHelper.show(context, event);
          return;
        }
        if (event is ToastEvent) {
          ToastHelper.showToast(context, event);
          return;
        }
        if (event is ProgressEvent) {
          ProgressHelper.handleProgressDialog(context, event);
          return;
        }
      });
    });
  }

  Widget buildBody(BuildContext context);
}

abstract class BasePageStatefulWidget extends StatefulWidget {
  const BasePageStatefulWidget({super.key});
}

abstract class BaseStatefulWidgetState<
  T extends BasePageStatefulWidget,
  S extends BaseService,
  P extends BaseProvider<S>
>
    extends State<T>
    with BasePageMixin<S, P> {
  StreamSubscription<List<ConnectivityResult>>? subscription;

  @override
  void initState() {
    super.initState();
    initEventListener(context);
    subscription = Connectivity().onConnectivityChanged.listen(_checkInternet);
  }

  @override
  dispose() {
    super.dispose();
    if (subscription != null) {
      subscription!.cancel();
    }
  }

  Future<void> _checkInternet(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      _showNoInternetDialog();
      return;
    }
    try {
      final lookup = await InternetAddress.lookup('google.com');
      if (lookup.isEmpty || lookup.first.rawAddress.isEmpty) {
        _showNoInternetDialog();
      }
    } on SocketException {
      _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    pageProvider(context).showDialog(
      type: DialogType.warring,
      title: "Thông báo",
      content: 'Internet có thể đang không ổn định. Hãy kết nối tới nguồn internet ổn định để sử dụng ứng dụng!',
    );
  }

  @override
  Widget build(BuildContext context) => buildRoot(context);
}

mixin BaseLoadMorePage {
  Widget generateList({
    required BuildContext context,
    required VoidCallback onRefresh,
    required VoidCallback onLoading,
    required RefreshController refreshController,
  }) {
    return SmartRefresher(
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(
              'Kéo để tải thêm',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = Text(
              'Thả tay để tải thêm',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
            );
          } else if (mode == LoadStatus.noMore) {
            body = Text(
              'Đã đến cuối danh sách',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
            );
          } else if (mode == LoadStatus.loading) {
            body = Text(
              'Đang tải thêm...',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
            );
          } else {
            body = Text(
              'Tải thêm thất bại!',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
            );
          }
          return SizedBox(height: 20.0, child: Center(child: body));
        },
      ),
      enablePullUp: enablePullUp,
      enablePullDown: enablePullDown,
      controller: refreshController,
      onRefresh: () => onRefresh.call(),
      onLoading: () => onLoading.call(),
      child: buildContentList(context),
    );
  }

  Widget buildContentList(BuildContext context);

  bool get enablePullUp => true;

  bool get enablePullDown => true;
}
