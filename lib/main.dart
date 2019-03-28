import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_stars/common/redux/AppState.dart';
import 'package:love_stars/routers/application.dart';
import 'package:love_stars/routers/routers.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(MyApp());
  //优化cache数目
  PaintingBinding.instance.imageCache.maximumSize = 100;
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
    Application.eventBus = new EventBus();
  }

  final store = new Store<AppState>(appReducer,

      ///初始化数据
      initialState: new AppState(
          themeData: ThemeData(platform: TargetPlatform.android),
          doneStarList: new List(),
          collectStarList: new List(),
          todoStarList: new List()));

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<AppState>(builder: (context, store) {
        return new MaterialApp(
          theme: store.state.themeData,
          onGenerateRoute: Application.router.generator,
        );
      }),
    );
  }
}
