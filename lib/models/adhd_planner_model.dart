import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adhd_planner_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ADHDPlannerModel extends HiveObject {
  @HiveField(0)
  String taskText;
  @HiveField(1)
  String id;
  @HiveField(2)
  bool isChecked;
  @HiveField(3)
  DateTime creationDate;
  @HiveField(4)
  DateTime deadlineDate;
  @HiveField(5)
  String taskType;
  @HiveField(6)
  String taskStatus;

  ADHDPlannerModel(this.taskText, this.id, this.isChecked, this.creationDate,
      this.deadlineDate, this.taskType, this.taskStatus);

  factory ADHDPlannerModel.fromJson(Map<String, dynamic> json) =>
      _$ADHDPlannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ADHDPlannerModelToJson(this);
}
