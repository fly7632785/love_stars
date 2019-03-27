import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_stars/common/dao/DaoResult.dart';
import 'package:love_stars/common/dao/StarDao.dart';
import 'package:love_stars/common/entity/DoneListResult.dart';
import 'package:love_stars/common/model/StarModel.dart';
import 'package:love_stars/common/redux/AppState.dart';
import 'package:love_stars/event/Events.dart';
import 'package:love_stars/routers/application.dart';
import 'package:love_stars/widget/ListState.dart';
import 'package:love_stars/widget/PullLoadWidget.dart';
import 'package:love_stars/widget/StarItem.dart';
import 'package:redux/redux.dart';
import 'package:event_bus/event_bus.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPage();
  }
}

class _FirstPage extends State<FirstPage>
    with AutomaticKeepAliveClientMixin<FirstPage>, ListState<FirstPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  _renderItem(e) {
    return new StarItem(
      true,
      e,
      onPressed: () {},
      onDonePressed: () {
        StarDao.doneStar(e);
        showRefreshLoading();
        Application.eventBus.fire(RefreshDoneListEvent());
      },
      onLongPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("删除"),
                content: new Text("确定要删除吗?"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text("取消")),
                  new FlatButton(
                      onPressed: () {
                        StarDao.deleteStar(e);
                        showRefreshLoading();
                        Application.eventBus.fire(RefreshDoneListEvent());
                        Navigator.pop(context);
                      },
                      child: new Text("确定")),
                ],
              );
            });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Application.eventBus.on<RefreshTodoListEvent>().listen((event) {
      showRefreshLoading();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pullLoadWidgetControl.dataList = _getStore().state.todoStarList;
  }

  @override
  requestRefresh() async {
    DataResult dataResult =
        await StarDao.getTodoStars(_getStore(), page: page) as DataResult;
    if (dataResult.data != null) {
      DoneListResult result = dataResult.data;
      pullLoadWidgetControl.total = result.total;
      return result.data;
    } else {
      return new List<StarModel>();
    }
  }

  @override
  requestLoadMore() async {
    DataResult dataResult =
        await StarDao.getTodoStars(_getStore(), page: page) as DataResult;
    DoneListResult result = dataResult.data;
    pullLoadWidgetControl.total = result.total;
    return result.data;
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(
      builder: (context, store) {
        return new PullLoadWidget(
          pullLoadWidgetControl,
          (BuildContext context, int index) =>
              _renderItem(pullLoadWidgetControl.dataList[index]),
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
        );
      },
    );
  }
}
