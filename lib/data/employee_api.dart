import 'package:employee/domain/models/employee.dart';

abstract class EmployeeApi {
  Future<List<Employee>> getEmployees();

  Future<bool> deleteEmployee(int i);

  Future<bool> undoDelete(int id);

  Future<bool> addEmployee(Employee employee);

  Future<bool> updateEmployeeData(Employee employee);
}
