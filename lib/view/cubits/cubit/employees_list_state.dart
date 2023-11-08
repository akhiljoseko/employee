part of 'employees_list_cubit.dart';

enum EmployeesListStateStatus {
  initial,
  loading,
  success,
  failure,
  employeeDeleted
}

class EmployeesListState extends Equatable {
  const EmployeesListState({
    this.status = EmployeesListStateStatus.initial,
    this.lastDeletedEmployee,
    this.employees = const [],
    this.error = "",
  });

  final EmployeesListStateStatus status;
  final List<Employee> employees;
  final Employee? lastDeletedEmployee;
  final String error;

  EmployeesListState copyWith({
    EmployeesListStateStatus? status,
    List<Employee>? employees,
    Employee? lastDeletedEmployee,
    String? error,
  }) {
    return EmployeesListState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      lastDeletedEmployee: lastDeletedEmployee ?? this.lastDeletedEmployee,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, employees, lastDeletedEmployee, error];
}
