part of 'employees_list_cubit.dart';

enum EmployeesListStateStatus { initial, loading, success, failure }

enum EmployeeListOperation { none, deleted, undo }

class EmployeesListState extends Equatable {
  const EmployeesListState({
    this.status = EmployeesListStateStatus.initial,
    this.lastDeletedEmployee,
    this.employees = const [],
    this.error = "",
    this.operation = EmployeeListOperation.none,
  });

  final EmployeesListStateStatus status;
  final List<Employee> employees;
  final Employee? lastDeletedEmployee;
  final String error;
  final EmployeeListOperation operation;

  EmployeesListState copyWith({
    EmployeesListStateStatus? status,
    List<Employee>? employees,
    Employee? lastDeletedEmployee,
    String? error,
    EmployeeListOperation? operation,
  }) {
    return EmployeesListState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      lastDeletedEmployee: lastDeletedEmployee ?? this.lastDeletedEmployee,
      error: error ?? this.error,
      operation: operation ?? this.operation,
    );
  }

  @override
  List<Object?> get props =>
      [status, employees, lastDeletedEmployee, error, operation];
}
