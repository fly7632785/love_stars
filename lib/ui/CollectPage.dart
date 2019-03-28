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

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CollectPage();
  }
}

class _CollectPage extends State<CollectPage>
    with AutomaticKeepAliveClientMixin<CollectPage>, ListState<CollectPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  _renderItem(e) {
    return new StarItem(
      false,
      e,
      onPressed: () {},
      onLongPressed: () {
        StarModel model = e;
        if (model.collectTime == null) {
          StarDao.collectStar(e);
        } else {
          StarDao.discollectStar(e);
        }
        showRefreshLoading();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Application.eventBus.on<RefreshDoneListEvent>().listen((event) {
      showRefreshLoading();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pullLoadWidgetControl.dataList = _getStore().state.doneStarList;
  }

  @override
  requestRefresh() async {
    DataResult dataResult =
    await StarDao.getCollectStars(_getStore(), page: page) as DataResult;
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
    await StarDao.getCollectStars(_getStore(), page: page) as DataResult;
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
        return Scaffold(
          appBar: AppBar(
            title: new Text("我的收藏"),
          ),
          body: new PullLoadWidget(
            pullLoadWidgetControl,
            (BuildContext context, int index) =>
                _renderItem(pullLoadWidgetControl.dataList[index]),
            handleRefresh,
            onLoadMore,
            refreshKey: refreshIndicatorKey,
          ),
        );
      },
    );
  }
}
