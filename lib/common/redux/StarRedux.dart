import 'package:love_stars/common/model/StarModel.dart';
import 'package:redux/redux.dart';

final TodoStarReducer = combineReducers<List<StarModel>>([
  TypedReducer<List<StarModel>, RefreshTodoStarAction>(_refresh),
  TypedReducer<List<StarModel>, LoadMoreTodoStarAction>(_loadmore),
]);

final DoneStarReducer = combineReducers<List<StarModel>>([
  TypedReducer<List<StarModel>, RefreshDoneStarAction>(_refresh),
  TypedReducer<List<StarModel>, LoadMoreDoneStarAction>(_loadmore),
]);

final CollectStarReducer = combineReducers<List<StarModel>>([
  TypedReducer<List<StarModel>, RefreshCollectStarAction>(_refresh),
  TypedReducer<List<StarModel>, LoadMoreCollectStarAction>(_loadmore),
]);

List<StarModel> _refresh(List<StarModel> list, action) {
  if (list != null) {
    list.clear();
    if (action.list == null) {
      return list;
    } else {
      list.addAll(action.list);
      return list;
    }
  }
  return list;
}

List<StarModel> _loadmore(List<StarModel> list, action) {
  if (action.list != null && list != null) {
    list.addAll(action.list);
  }
  return list;
}

class RefreshTodoStarAction {
  final List<StarModel> list;

  RefreshTodoStarAction(this.list);
}

class LoadMoreTodoStarAction {
  final List<StarModel> list;
  LoadMoreTodoStarAction(this.list);
}

class RefreshDoneStarAction {
  final List<StarModel> list;

  RefreshDoneStarAction(this.list);
}

class LoadMoreDoneStarAction {
  final List<StarModel> list;

  LoadMoreDoneStarAction(this.list);
}

class RefreshCollectStarAction {
  final List<StarModel> list;

  RefreshCollectStarAction(this.list);
}

class LoadMoreCollectStarAction {
  final List<StarModel> list;

  LoadMoreCollectStarAction(this.list);
}
