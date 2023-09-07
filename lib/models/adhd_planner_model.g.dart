// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adhd_planner_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ADHDPlannerModelAdapter extends TypeAdapter<ADHDPlannerModel> {
  @override
  final int typeId = 0;

  @override
  ADHDPlannerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ADHDPlannerModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
      fields[3] as DateTime,
      fields[4] as DateTime,
      fields[5] as String,
      fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ADHDPlannerModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.taskText)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.isChecked)
      ..writeByte(3)
      ..write(obj.creationDate)
      ..writeByte(4)
      ..write(obj.deadlineDate)
      ..writeByte(5)
      ..write(obj.taskType)
      ..writeByte(6)
      ..write(obj.taskStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ADHDPlannerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ADHDPlannerModel _$ADHDPlannerModelFromJson(Map<String, dynamic> json) =>
    ADHDPlannerModel(
      json['taskText'] as String,
      json['id'] as String,
      json['isChecked'] as bool,
      DateTime.parse(json['creationDate'] as String),
      DateTime.parse(json['deadlineDate'] as String),
      json['taskType'] as String,
      json['taskStatus'] as String,
    );

Map<String, dynamic> _$ADHDPlannerModelToJson(ADHDPlannerModel instance) =>
    <String, dynamic>{
      'taskText': instance.taskText,
      'id': instance.id,
      'isChecked': instance.isChecked,
      'creationDate': instance.creationDate.toIso8601String(),
      'deadlineDate': instance.deadlineDate.toIso8601String(),
      'taskType': instance.taskType,
      'taskStatus': instance.taskStatus,
    };
