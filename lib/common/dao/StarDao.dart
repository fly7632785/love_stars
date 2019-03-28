import 'package:love_stars/common/config/Config.dart';
import 'package:love_stars/common/dao/DaoResult.dart';
import 'package:love_stars/common/db/StarDbProvider.dart';
import 'package:love_stars/common/entity/DoneListResult.dart';
import 'package:love_stars/common/model/StarModel.dart';
import 'package:love_stars/common/redux/StarRedux.dart';
import 'package:redux/redux.dart';

class StarDao {
  static getTodoStars(Store store, {page = 0, needDb = true}) async {
    StarDbProvider provider = new StarDbProvider();
    List<StarModel> list = await provider.getTodoData(page, Config.PAGE_SIZE);
    int total = await provider.getTodoTotal();
    if (list != null && list.length > 0) {
      if (page == 0) {
        store.dispatch(new RefreshTodoStarAction(list));
      } else {
        store.dispatch(new LoadMoreTodoStarAction(list));
      }
      return new DataResult(
          new DoneListResult(list, Config.PAGE_SIZE, page, total), true);
    } else {
      return new DataResult(
          new DoneListResult(list, Config.PAGE_SIZE, page, total), false);
    }
  }

  static getDoneStars(Store store, {page = 0, needDb = true}) async {
    StarDbProvider provider = new StarDbProvider();
    List<StarModel> list = await provider.getDoneData(page, Config.PAGE_SIZE);
    int total = await provider.getDoneTotal();
    if (list != null && list.length > 0) {
      if (page == 0) {
        store.dispatch(new RefreshDoneStarAction(list));
      } else {
        store.dispatch(new LoadMoreDoneStarAction(list));
      }
      return new DataResult(
          new DoneListResult(list, Config.PAGE_SIZE, page, total), true);
    } else {
      return new DataResult(
          new DoneListResult(list, Config.PAGE_SIZE, page, total), false);
    }
  }

  static getCollectStars(Store store, {page = 0, needDb = true}) async {
    StarDbProvider provider = new StarDbProvider();
    List<StarModel> list = await provider.getCollectData(page, Config.PAGE_SIZE);
    int total = await provider.getCollectTotal();
    if (list != null && list.length > 0) {
      if (page == 0) {
        store.dispatch(new RefreshCollectStarAction(list));
      } else {
        store.dispatch(new LoadMoreCollectStarAction(list));
      }
      return new DataResult(
          new DoneListResult(list, Config.PAGE_SIZE, page, total), true);
    } else {
      return new DataResult(
          new DoneListResult(list, Config.PAGE_SIZE, page, total), false);
    }
  }

  static insertStar(StarModel model) async {
    StarDbProvider provider = new StarDbProvider();
    await provider.insert(model.toJson());
  }

  static collectStar(StarModel model) async {
    StarDbProvider provider = new StarDbProvider();
    await provider.collect(model,DateTime.now().millisecondsSinceEpoch);
  }

  static discollectStar(StarModel model) async {
    StarDbProvider provider = new StarDbProvider();
    await provider.discollect(model);
  }

  static deleteStar(StarModel model) async {
    StarDbProvider provider = new StarDbProvider();
    await provider.delete(model.id);
  }

  static doneStar(StarModel model) async {
    model.doneTime = DateTime.now().millisecondsSinceEpoch;
    StarDbProvider provider = new StarDbProvider();
    await provider.doneStar(model);
  }
}
