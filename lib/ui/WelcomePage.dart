import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_stars/common/config/Config.dart';
import 'package:love_stars/common/local/LocalStorage.dart';
import 'package:love_stars/common/redux/AppState.dart';
import 'package:love_stars/common/style/AppColors.dart';
import 'package:love_stars/common/util/CommonUtils.dart';
import 'package:love_stars/routers/application.dart';
import 'package:love_stars/routers/routers.dart';
import 'package:redux/redux.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<AppState> store = StoreProvider.of(context);

    ///防止多次进入
    new Future.delayed(const Duration(seconds: 2), () {
      initData(store);
      Application.router.navigateTo(context, Routes.home, replace: true);
      super.didChangeDependencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return new Container(
          color: Color(AppColors.white),
          child: new Center(
            child:
                new Image(image: new AssetImage('static/images/welcome.png')),
          ),
        );
      },
    );
  }

  static initData(Store<AppState> store) async {
    ///读取主题
    String themeIndex = await LocalStorage.get(Config.THEME_COLOR);
    if (themeIndex != null && themeIndex.length != 0) {
      CommonUtils.pushTheme(store, int.parse(themeIndex));
    }
  }
}
