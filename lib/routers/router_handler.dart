import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:love_stars/ui/HomePage.dart';


// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new HomePage();
  },
);

//var categoryHandler = new Handler(
//  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//    String name = params["type"]?.first;
//    return new CategoryHome(name);
//  },
//);
//
////var widgetNotFoundHandler = new Handler(
////    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
////  return new WidgetNotFound();
////});
////
////var fullScreenCodeDialog = new Handler(
////    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
////  String path = params['filePath']?.first;
////  return new FullScreenCodeDialog(
////    filePath: path,
////  );
////});
////
////var webViewPageHand = new Handler(
////    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
////  String title = params['title']?.first;
////  String url = params['url']?.first;
////  return new WebViewPage(url, title);
////});
