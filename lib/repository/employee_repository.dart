import 'package:flutter_employee_hive_bloc/constants/strings.dart';
import 'package:flutter_employee_hive_bloc/db/hive_services.dart';
import 'package:flutter_employee_hive_bloc/models/new_employee_list.dart';
import 'package:flutter_employee_hive_bloc/utils/utility.dart';

class EmployeeRepository {
  /// [EmployeeList] Functions --------------------------------------------------

  Future<List<EmployeeList>> getAllEmployeeLists() async {
    var hasLength = await HiveServices.hasLength<EmployeeList>(employeeLists);
    if (!hasLength) return [];

    var data = await HiveServices.getAll<EmployeeList>(employeeLists);
    return data;
  }

  Future<EmployeeList> getEmployeeByID(String id) async {
    var item = await HiveServices.get<EmployeeList>(employeeLists, id);
    return item!;
  }

  Future<bool> checkIfListAlreadyExistsWithTitle(String title) async {
    var data = await HiveServices.getAll<EmployeeList>(employeeLists);

    if (data.isNotEmpty) {
      for (var item in data) {
        if (item.title.toLowerCase() == title.toLowerCase()) return true;
      }
    }

    return false;
  }

  Future<EmployeeList> addEmployeeList(
      String title, String role, DateTime fromD, DateTime? toD) async {
    var uid = AppUtility.generateUid(16);
    AppUtility.log('EmployeeListUid: $uid');

    var item = EmployeeList(
      id: uid,
      title: title,
      role: role,
      fromDate: fromD,
      toDate: toD ?? null,
    );

    await HiveServices.put<EmployeeList>(employeeLists, uid, item);
    return item;
  }

  Future<EmployeeList?> updateEmployeeList(
    String uid, {
    String? title,
    String? role,
    DateTime? fromD,
    DateTime? toD
  }) async {
    var item = await HiveServices.get<EmployeeList>(employeeLists, uid);

    await HiveServices.delete<EmployeeList>(employeeLists, uid);
    await HiveServices.put<EmployeeList>(
        employeeLists,
        uid,
        EmployeeList(
            id: uid,
            title: title!,
            role: role,
            fromDate:fromD!,
            toDate: toD!));

    return item;
  }

  Future<void> deleteEmployeeList(String id) async {
    if (id.isEmpty) {
      AppUtility.log('id is empty');
      return;
    }

    await HiveServices.delete<EmployeeList>(employeeLists, id);
  }
}
