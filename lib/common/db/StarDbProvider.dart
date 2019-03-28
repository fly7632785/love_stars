import 'package:love_stars/common/db/SqlProvider.dart';
import 'package:love_stars/common/model/StarModel.dart';
import 'package:sqflite/sqflite.dart';

class StarDbProvider extends BaseDbProvider {
  final String name = 'StarRepository';

  final String columnId = "_id";
  final String columnTodoTime = "todo_time";
  final String columnCreateTime = "create_time";
  final String columnContent = "content";
  final String columnDoneTime = "done_time";
  final String columnCollectTime = "collect_time";

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnTodoTime int,
        $columnCreateTime int,
        $columnDoneTime int,
        $columnContent text,
        $columnCollectTime int
        )
      ''';
  }

  Future doneStar(StarModel model) async {
    Database db = await getDataBase();
    return await db.rawUpdate(
        "update $name set $columnDoneTime = ${model.doneTime} where _id = ${model.id}");
  }

  ///插入到数据库
  Future insert(Map<String, dynamic> data) async {
    Database db = await getDataBase();
    return await db.insert(name, data);
  }

  Future collect(StarModel model, int time) async {
    Database db = await getDataBase();
    return await db.rawUpdate(
        "update $name set $columnCollectTime = $time where _id = ${model.id}");
  }

  Future discollect(StarModel model) async {
    Database db = await getDataBase();
    return await db.rawUpdate(
        "update $name set $columnCollectTime = null where _id = ${model.id}");
  }

  Future delete(int id) async {
    Database db = await getDataBase();
    return await db.delete(name, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> getTodoTotal() async {
    Database db = await getDataBase();
    int total = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM $name where $columnDoneTime is null'));
    return total;
  }

  Future<int> getDoneTotal() async {
    Database db = await getDataBase();
    int total = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $name where $columnDoneTime is not null'));
    return total;
  }

  Future<int> getCollectTotal() async {
    Database db = await getDataBase();
    int total = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $name where $columnCollectTime is not null'));
    return total;
  }

  Future<List<StarModel>> getCollectData(int page, int pageSize) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(name,
        columns: [
          columnId,
          columnContent,
          columnTodoTime,
          columnCreateTime,
          columnDoneTime,
          columnCollectTime,
        ],
        where: columnCollectTime + " is not null",
        limit: pageSize,
        orderBy: columnCollectTime + " DESC",
        offset: pageSize * page);
    List<StarModel> list = new List();
    for (var value in maps) {
      list.add(StarModel.fromJson(value));
    }
    return list;
  }

  Future<List<StarModel>> getTodoData(int page, int pageSize) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(name,
        columns: [
          columnId,
          columnContent,
          columnTodoTime,
          columnCreateTime,
          columnDoneTime,
          columnCollectTime,
        ],
        where: columnDoneTime + " is null",
        limit: pageSize,
        orderBy: columnCreateTime + " DESC",
        offset: pageSize * page);
    List<StarModel> list = new List();
    for (var value in maps) {
      list.add(StarModel.fromJson(value));
    }
    return list;
  }

  Future<List<StarModel>> getDoneData(int page, int pageSize) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(name,
        columns: [
          columnId,
          columnContent,
          columnTodoTime,
          columnCreateTime,
          columnDoneTime,
          columnCollectTime,
        ],
        where: columnDoneTime + " is not null",
        limit: pageSize,
        orderBy: columnDoneTime + " DESC",
        offset: pageSize * page);
    List<StarModel> list = new List();
    for (var value in maps) {
      list.add(StarModel.fromJson(value));
    }
    return list;
  }
}
