// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_employee_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeListAdapter extends TypeAdapter<EmployeeList> {
  @override
  final int typeId = 1;

  @override
  EmployeeList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeList(
      id: fields[0] as String,
      title: fields[1] as String,
      role: fields[2] as String?,
      fromDate: fields[3] as DateTime,
      toDate: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.fromDate)
      ..writeByte(4)
      ..write(obj.toDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
