import 'package:flutter/material.dart';
import 'package:love_stars/routers/application.dart';
import 'package:love_stars/routers/routers.dart';
import 'package:love_stars/ui/FirstPage.dart';
import 'package:love_stars/ui/FourthPage.dart';
import 'package:love_stars/ui/SecondPage.dart';
import 'package:love_stars/ui/ThirdPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text("exit?"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text("cancel")),
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: new Text("ok"))
              ],
            ));
  }

  TabController controller;
  bool isSearch = false;
  String data = '无';
  String appBarTitle = tabData[0]['text'];
  static List tabData = [
//    {'text': '首页', 'icon': new Icon(Icons.language)},
    {'text': '未完成', 'icon': new Icon(Icons.extension)},
    {'text': '已完成', 'icon': new Icon(Icons.favorite)},
    {'text': '我的', 'icon': new Icon(Icons.import_contacts)}
  ];

  List<Widget> myTabs = [];

  @override
  void initState() {
    super.initState();

    controller = new TabController(
        initialIndex: 0, vsync: this, length: 4); // 这里的length 决定有多少个底导 submenus
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
  }

  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("love_stars"),
          actions: <Widget>[
            new FlatButton(
              onPressed: _onAdd,
              child: new Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: new TabBarView(controller: controller, children: <Widget>[
          new FirstPage(),
          new SecondPage(),
          new ThirdPage(),
//          new FourthPage()
        ]),
        bottomNavigationBar: Material(
          color: const Color(0xFFF0EEEF), //底部导航栏主题颜色
          child: SafeArea(
            child: Container(
              height: 65.0,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFFd0d0d0),
                    blurRadius: 3.0,
                    spreadRadius: 2.0,
                    offset: Offset(-1.0, -1.0),
                  ),
                ],
              ),
              child: TabBar(
                  controller: controller,
                  indicatorColor: Theme.of(context).primaryColor,
                  //tab标签的下划线颜色
                  // labelColor: const Color(0xFF000000),
                  indicatorWeight: 3.0,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: const Color(0xFF8E8E8E),
                  tabs: myTabs),
            ),
          ),
        ),
      ),
    );
  }

  void _onAdd() {
    Application.router.navigateTo(context, Routes.create);
  }
}
