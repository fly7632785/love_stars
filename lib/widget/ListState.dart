import 'dart:async';
import 'package:flutter/material.dart';
import 'package:love_stars/widget/PullLoadWidget.dart';

/**
 * 上下拉刷新列表的通用State
 */
mixin ListState<T extends StatefulWidget>
    on State<T>, AutomaticKeepAliveClientMixin<T> {
  bool isShow = false;

  bool isLoading = false;

  int page = 0;

  final List dataList = new List();

  final PullLoadWidgetControl pullLoadWidgetControl =
      new PullLoadWidgetControl();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      refreshIndicatorKey.currentState?.show()?.then((e) {});
      return true;
    });
  }

  @protected
  resolveRefreshResult(list) {
//    if (res != null && res.result) {
    if (list != null) {
      pullLoadWidgetControl.dataList.clear();
      if (isShow) {
        setState(() {
          pullLoadWidgetControl.dataList.addAll(list);
        });
      }
    }
  }

  @protected
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 0;
    var list = await requestRefresh();
    if(list != null) {
      resolveRefreshResult(list);
      resolveDataResult(list);
//      if (res.next != null) {
//        var resNext = await res.next;
//        resolveRefreshResult(resNext);
//        resolveDataResult(resNext);
//      }
    }
    isLoading = false;
    return null;
  }

  @protected
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    var list = await requestLoadMore();
    if (list != null) {
      if (isShow) {
        setState(() {
          pullLoadWidgetControl.dataList.addAll(list);
        });
      }
    }
    resolveDataResult(list);
    isLoading = false;
    return null;
  }

  @protected
  resolveDataResult(list) {
    if (isShow) {
      setState(() {
        pullLoadWidgetControl.needLoadMore = (list   != null
            && pullLoadWidgetControl.dataList.length < pullLoadWidgetControl.total);
      });
    }
  }

  @protected
  clearData() {
    if (isShow) {
      setState(() {
        pullLoadWidgetControl.dataList.clear();
      });
    }
  }

  ///下拉刷新数据
  @protected
  requestRefresh() async {}

  ///上拉更多请求数据
  @protected
  requestLoadMore() async {}

  ///是否需要第一次进入自动刷新
  @protected
  bool get isRefreshFirst;

  ///是否需要头部
  @protected
  bool get needHeader => false;

  ///是否需要保持
  @override
  bool get wantKeepAlive => true;

  List get getDataList => dataList;

  @override
  void initState() {
    isShow = true;
    super.initState();
    pullLoadWidgetControl.needHeader = needHeader;
    pullLoadWidgetControl.dataList = getDataList;
    if (pullLoadWidgetControl.dataList.length == 0 && isRefreshFirst) {
      showRefreshLoading();
    }
  }

  @override
  void dispose() {
    isShow = false;
    isLoading = false;
    super.dispose();
  }
}
