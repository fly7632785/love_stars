import 'package:json_annotation/json_annotation.dart';

part 'StarModel.g.dart';

@JsonSerializable()
class StarModel {
  @JsonKey(name: "_id")
  int id;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "create_time")
  int createTime;
  @JsonKey(name: "done_time")
  int doneTime;
  @JsonKey(name: "todo_time")
  int todoTime;
  @JsonKey(name: "collect_time")
  int collectTime;

  StarModel(this.content, this.createTime, this.doneTime, this.todoTime,
      {this.id,this.collectTime});

  factory StarModel.fromJson(Map<String, dynamic> json) =>
      _$StarModelFromJson(json);

  Map<String, dynamic> toJson() => _$StarModelToJson(this);
}
