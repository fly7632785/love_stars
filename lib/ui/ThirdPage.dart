import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_stars/common/config/Config.dart';
import 'package:love_stars/common/local/LocalStorage.dart';
import 'package:love_stars/common/redux/AppState.dart';
import 'package:love_stars/common/redux/ThemeDataReducer.dart';
import 'package:love_stars/common/style/AppColors.dart';
import 'package:love_stars/common/style/AppStyle.dart';
import 'package:love_stars/common/util/CommonUtils.dart';
import 'package:love_stars/routers/application.dart';
import 'package:love_stars/routers/routers.dart';
import 'package:love_stars/widget/Line.dart';
import 'package:redux/redux.dart';

class ThirdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThirdPage();
  }
}

class _ThirdPage extends State<ThirdPage> with AutomaticKeepAliveClientMixin {
  showThemeDialog(BuildContext context, Store store) {
    List<String> list = [
      "theme_default",
      "theme_1",
      "theme_2",
      "theme_3",
      "theme_4",
      "theme_5",
      "theme_6",
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.pushTheme(store, index);
      LocalStorage.save(Config.THEME_COLOR, index.toString());
    }, colorList: CommonUtils.getThemeListColor());
  }

  _renderItem(
      IconData leftIcon, String title, String value, VoidCallback onPressed) {
    return new RawMaterialButton(
      onPressed: onPressed,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(15.0),
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      child: new Row(
        children: <Widget>[
          new Icon(leftIcon),
          new Container(
            width: 10.0,
          ),
          new Text(title, style: AppStyle.middleSubText),
          new Container(
            width: 10.0,
          ),
          new Expanded(child: new Text(value, style: AppStyle.middleSubText)),
          new Container(
            width: 10.0,
          ),
          new Icon(Icons.keyboard_arrow_right, size: 20.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(
      builder: (context, store) {
        return new Column(
          children: <Widget>[
            new Container(
              height: 200,
              alignment: Alignment.center,
              color: store.state.themeData.primaryColor,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new CircleAvatar(
                    radius: 30,
                    //圆形图标控件
                    backgroundImage: new AssetImage(
                      "static/images/logo.png",
                    ),
                    backgroundColor: Color(AppColors.white),
                  ),
                  new Text("love_stars", style: AppStyle.whiteText)
                ],
              ),
            ),
            _renderItem(Icons.turned_in, "我的收藏", "", () {
              Application.router.navigateTo(context, Routes.collect);
            }),
            new H_Line(),
            _renderItem(Icons.toys, "更换主题", "", () {
              showThemeDialog(context, store);
            }),
            new H_Line(),
            _renderItem(Icons.settings, "设置", "", () {}),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
