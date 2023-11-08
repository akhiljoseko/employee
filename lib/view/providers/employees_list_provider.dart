import 'package:employee/app/base_provider.dart';
import 'package:employee/domain/employee_repository.dart';
import 'package:employee/domain/models/employee.dart';

class EmployeesListProvider extends BaseProvider {
  final EmployeeRepository employeeRepository;

  EmployeesListProvider({required this.employeeRepository}) {
    _getEmployees();
  }

  Future<void> _getEmployees() async {
    busy();
    final result = await employeeRepository.getEmployees();
    result.fold(
      (error) => addError(error.message),
      (employeesList) {
        employees.clear();
        employees.addAll(employeesList);
      },
    );
    idle();
  }

  List<Employee> employees = [];
  void refresh() {
    _getEmployees();
  }

  late int lastDeletedIndex;
  void deleteEmployee(Employee deletedEmployee) {
    lastDeletedIndex = employees.indexOf(deletedEmployee);
    employees.removeAt(lastDeletedIndex);
    if (deletedEmployee.id != null) {
      employeeRepository.deleteEmployee(deletedEmployee.id!);
    }
    notifyListeners();
  }

  void undoEmployeeDeletion(Employee deletedEmployee) {
    final newInstanceOfSameEmployee = deletedEmployee.copy();
    employees.insert(lastDeletedIndex, newInstanceOfSameEmployee);
    if (deletedEmployee.id != null) {
      employeeRepository.undoEmployeeDeletion(deletedEmployee.id!);
    }

    notifyListeners();
  }
}
