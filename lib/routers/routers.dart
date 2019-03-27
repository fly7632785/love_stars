import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:love_stars/ui/CreatePage.dart';
import 'package:love_stars/ui/WelcomePage.dart';

import './router_handler.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String create = "/create";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc:
            (BuildContext context, Map<String, List<String>> params) {});
    router.define(root,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    WelcomePage()));
    router.define(home, handler: homeHandler);
    router.define(create,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    CreatePage()));
  }
}
