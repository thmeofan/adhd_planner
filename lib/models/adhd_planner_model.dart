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

  factory ADHDPlannerModel.fromJson(Map<String, dynamic> json) {
    return ADHDPlannerModel(
      json['taskText'] as String? ?? '',
      json['id'] as String? ?? '',
      json['isChecked'] as bool? ?? false,
      _parseCustomDate(json['creationDate']),
      _parseCustomDate(json['deadlineDate']),
      json['taskType'] as String? ?? '',
      json['taskStatus'] as String? ?? '',
    );
  }

  static DateTime _parseCustomDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      // Return a default date value, such as the current date/time, or any other appropriate default.
      return DateTime.now();
    }

    try {
      // Implement your custom date parsing logic here.
      // Example: Parse dateStr into DateTime using a specific format.
      // DateTime parsedDate = customDateParsingLogic(dateStr);
      // return parsedDate;

      // For simplicity, let's assume dateStr is in ISO 8601 format.
      return DateTime.parse(dateStr);
    } catch (e) {
      // If parsing fails, return a default date value or handle the error as needed.
      // You might want to log the error or throw a custom exception.
      return DateTime.now();
    }
  }



  Map<String, dynamic> toJson() => _$ADHDPlannerModelToJson(this);
}
