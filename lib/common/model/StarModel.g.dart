// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StarModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarModel _$StarModelFromJson(Map<String, dynamic> json) {
  return StarModel(json['content'] as String, json['create_time'] as int,
      json['done_time'] as int, json['todo_time'] as int,
      id: json['_id'] as int, collectTime: json['collect_time'] as int);
}

Map<String, dynamic> _$StarModelToJson(StarModel instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'create_time': instance.createTime,
      'done_time': instance.doneTime,
      'todo_time': instance.todoTime,
      'collect_time': instance.collectTime,
    };
