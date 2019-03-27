import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:love_stars/common/redux/AppState.dart';
import 'package:love_stars/common/style/AppColors.dart';
import 'package:love_stars/routers/application.dart';
import 'package:love_stars/routers/routers.dart';

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
    new Future.delayed(const Duration(seconds: 2), () {
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
}
