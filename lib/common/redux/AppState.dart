import 'package:flutter/material.dart';
import 'package:love_stars/common/model/StarModel.dart';
import 'package:love_stars/common/redux/StarRedux.dart';
import 'package:love_stars/common/redux/ThemeDataReducer.dart';

/// redux的全局state
class AppState {
  ///主题数据
  ThemeData themeData;

  List<StarModel> todoStarList = new List();
  List<StarModel> doneStarList = new List();
  List<StarModel> collectStarList = new List();


  AppState({this.themeData, this.todoStarList, this.doneStarList,this.collectStarList});
}

AppState appReducer(AppState state, action) {
  return AppState(
    ///通过 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
    themeData: ThemeDataReducer(state.themeData, action),
    todoStarList: TodoStarReducer(state.todoStarList, action),
    doneStarList: DoneStarReducer(state.doneStarList, action),
    collectStarList: CollectStarReducer(state.collectStarList, action),
  );
}
