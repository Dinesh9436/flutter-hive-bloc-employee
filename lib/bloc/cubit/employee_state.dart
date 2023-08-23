part of 'employee_cubit.dart';


enum EmployeeListStatus { initial, loading, success, failure }

extension EmployeeListStatusX on EmployeeListStatus {
  bool get isInitial => this == EmployeeListStatus.initial;
  bool get isLoading => this == EmployeeListStatus.loading;
  bool get isSuccess => this == EmployeeListStatus.success;
  bool get isFailure => this == EmployeeListStatus.failure;
}

@JsonSerializable()
class EmployeeListState extends Equatable {
  EmployeeListState({
    this.status = EmployeeListStatus.initial,
    List<EmployeeList>? employeeLists,
    String? errorMessage,
  })  : employeeLists = employeeLists ?? [],
        errorMessage = errorMessage ?? '';

  

  final EmployeeListStatus status;
  final List<EmployeeList> employeeLists;
  final String errorMessage;

  EmployeeListState copyWith({
    EmployeeListStatus? status,
    List<EmployeeList>? employeeLists,
    String? errorMessage,
  }) {
    return EmployeeListState(
      status: status ?? this.status,
      employeeLists: employeeLists ?? this.employeeLists,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, employeeLists, errorMessage];
}
