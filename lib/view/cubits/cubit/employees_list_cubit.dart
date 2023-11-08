import 'package:bloc/bloc.dart';
import 'package:employee/domain/employee_repository.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:equatable/equatable.dart';

part 'employees_list_state.dart';

class EmployeesListCubit extends Cubit<EmployeesListState> {
  final EmployeeRepository employeeRepository;

  EmployeesListCubit({
    required this.employeeRepository,
  }) : super(const EmployeesListState()) {
    _getEmployees();
  }

  Future<void> _getEmployees() async {
    emit(state.copyWith(
      status: EmployeesListStateStatus.loading,
      error: "",
    ));
    final result = await employeeRepository.getEmployees();
    result.fold(
      (error) => emit(
        state.copyWith(
          status: EmployeesListStateStatus.failure,
          error: error.message,
        ),
      ),
      (employeeList) => emit(state.copyWith(
        status: EmployeesListStateStatus.success,
        employees: employeeList,
      )),
    );
  }

  late int lastDeletedEmployeeIndex;
  void deleteEmployee(Employee deletedEmployee) {
    emit(state.copyWith(operation: EmployeeListOperation.none));
    employeeRepository.deleteEmployee(deletedEmployee);
    lastDeletedEmployeeIndex = state.employees.indexOf(deletedEmployee);
    state.employees.removeAt(lastDeletedEmployeeIndex);
    emit(state.copyWith(operation: EmployeeListOperation.deleted));
  }

  void undoEmployeeDeletion(Employee deletedEmployee) {
    employeeRepository.undoEmployeeDeletion(deletedEmployee);
    state.employees
        .insert(lastDeletedEmployeeIndex, deletedEmployee.copyWith());
    emit(state.copyWith(operation: EmployeeListOperation.undo));
  }

  void refresh() {
    _getEmployees();
  }
}
