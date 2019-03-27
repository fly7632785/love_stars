import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

final ThemeDataReducer = combineReducers<ThemeData>(
    [
      TypedReducer<ThemeData, RefreshThemeDataAction>(_refresh),
    ]
);

ThemeData _refresh(ThemeData state, RefreshThemeDataAction action) {
  state = action.themeData;
  return state;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshThemeDataAction {

  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}
