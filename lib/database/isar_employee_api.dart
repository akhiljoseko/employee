import 'package:employee/data/employee_api.dart';
import 'package:employee/database/schema/employee_entity.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarEmployeeApi implements EmployeeApi {
  static Isar? isar;

  static Future<void> initApi() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [EmployeeEntitySchema],
      directory: dir.path,
    );
  }

  @override
  Future<bool> addEmployee(Employee employee) async {
    final newEmployee = EmployeeEntity()
      ..name = employee.name
      ..roleId = employee.roleId
      ..fromDate = employee.fromDate
      ..toDate = employee.toDate
      ..isDeleted = false;
    final insertedId = await isar?.writeTxn<int?>(
      () async {
        return await isar?.employeeEntitys.put(newEmployee);
      },
    );
    return insertedId != null;
  }

  @override
  Future<bool> deleteEmployee(int id) async {
    final employee = await isar?.employeeEntitys.get(id);
    if (employee != null) {
      employee.isDeleted = true;
      final deletedId = await isar?.writeTxn<int?>(
        () async {
          return await isar?.employeeEntitys.put(employee);
        },
      );
      return deletedId == id;
    }
    return false;
  }

  @override
  Future<List<Employee>> getEmployees() async {
    final employeeList = await isar?.employeeEntitys
            .where()
            .filter()
            .isDeletedEqualTo(false)
            .findAll() ??
        [];

    return List<Employee>.from(
      employeeList
          .map(
            (e) => Employee(
              id: e.id,
              name: e.name,
              roleId: e.roleId,
              fromDate: e.fromDate,
              toDate: e.toDate,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<bool> undoDelete(int id) async {
    final employee = await isar?.employeeEntitys.get(id);
    if (employee != null) {
      employee.isDeleted = false;
      final updatedId = await isar?.writeTxn<int?>(
        () async {
          return await isar?.employeeEntitys.put(employee);
        },
      );
      return updatedId == id;
    }
    return false;
  }

  @override
  Future<bool> updateEmployeeData(Employee updatedEmployeeDetails) async {
    final employee =
        await isar?.employeeEntitys.get(updatedEmployeeDetails.id!);
    if (employee != null) {
      employee.name = updatedEmployeeDetails.name;
      employee.roleId = updatedEmployeeDetails.roleId;
      employee.fromDate = updatedEmployeeDetails.fromDate;
      employee.toDate = updatedEmployeeDetails.toDate;
      final updatedId = await isar?.writeTxn<int?>(
        () async {
          return await isar?.employeeEntitys.put(employee);
        },
      );
      return updatedId == updatedEmployeeDetails.id;
    }
    return false;
  }
}
