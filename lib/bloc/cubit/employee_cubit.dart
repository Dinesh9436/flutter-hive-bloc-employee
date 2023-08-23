import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_employee_hive_bloc/models/new_employee_list.dart';
import 'package:flutter_employee_hive_bloc/repository/employee_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_state.dart';


class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit(this._employeeRepository) : super(EmployeeListState());

  final EmployeeRepository _employeeRepository;

  Future<void> getEmployeeLists() async {
    emit(state.copyWith(status: EmployeeListStatus.loading));

    try {
      final data = await _employeeRepository.getAllEmployeeLists();

      emit(state.copyWith(
        status: EmployeeListStatus.success,
        employeeLists: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeListStatus.failure,
        errorMessage: e.toString(),
        employeeLists: [...state.employeeLists],
      ));
    }
  }

  

  Future<void> addEmployeeList(String title,String role, DateTime fromD,DateTime? toD) async {
    emit(state.copyWith(status: EmployeeListStatus.loading));

    try {
      var isExists =
          await _employeeRepository.checkIfListAlreadyExistsWithTitle(title);

      if (isExists) {
        emit(state.copyWith(
          status: EmployeeListStatus.failure,
          errorMessage: 'Employee list with this title already exists',
          employeeLists: [...state.employeeLists],
        ));
      } else {
        var item = await _employeeRepository.addEmployeeList(title,role,fromD,toD);

        emit(state.copyWith(
          status: EmployeeListStatus.success,
          employeeLists: [...state.employeeLists, item],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeListStatus.failure,
        errorMessage: e.toString(),
        employeeLists: [...state.employeeLists],
      ));
    }
  }

  Future<void> updateEmployeeList(String id, String title,String role, DateTime fromD, DateTime toD) async {
    emit(state.copyWith(status: EmployeeListStatus.loading));

    try {
      var isExists =
          await _employeeRepository.checkIfListAlreadyExistsWithTitle(title);

      if (isExists) {
        emit(state.copyWith(
          status: EmployeeListStatus.failure,
          errorMessage: 'Employee list with this title already exists',
          employeeLists: [...state.employeeLists],
        ));
      } else {
        var item =
            await _employeeRepository.updateEmployeeList(id, title: title,role: role,fromD: fromD,toD: toD);

        if (item == null) {
          emit(state.copyWith(
            status: EmployeeListStatus.failure,
            errorMessage: 'Employee list not found',
            employeeLists: [...state.employeeLists],
          ));
        } else {
          var index =
              state.employeeLists.indexWhere((element) => element.id == id);
          var temp = [...state.employeeLists];
          temp[index] = item;

          emit(state.copyWith(
            status: EmployeeListStatus.success,
            employeeLists: temp,
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeListStatus.failure,
        errorMessage: e.toString(),
        employeeLists: [...state.employeeLists],
      ));
    }
  }

  Future<void> deleteEmployeeList(String id) async {
    emit(state.copyWith(status: EmployeeListStatus.loading));

    try {
      await _employeeRepository.deleteEmployeeList(id);

      var temp = [...state.employeeLists];
      temp.removeWhere((element) => element.id == id);

      emit(state.copyWith(
        status: EmployeeListStatus.success,
        employeeLists: temp,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeListStatus.failure,
        errorMessage: e.toString(),
        employeeLists: [...state.employeeLists],
      ));
    }
  }
}
