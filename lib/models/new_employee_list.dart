import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'new_employee_list.g.dart';




@HiveType(typeId: 1)
class EmployeeList extends HiveObject {
  EmployeeList({
    required this.id,
    required this.title,
    this.role,
    required this.fromDate,
    required this.toDate,
  });

  

 
  @HiveField(0)
  final String id;

 
  @HiveField(1)
  final String title;

 
  @HiveField(2)
  final String? role;


  @HiveField(3)
  final DateTime fromDate;

 
  @HiveField(4)
  final DateTime? toDate;

 
}
