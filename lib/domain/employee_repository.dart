import 'package:dartz/dartz.dart';
import 'package:employee/app/errors.dart';
import 'package:employee/domain/models/employee.dart';

abstract class EmployeeRepository {
  Future<Either<CustomException, List<Employee>>> getEmployees();

  Future<Either<CustomException, bool>> deleteEmployee(int deletedEmployeeId);

  Future<Either<CustomException, bool>> undoEmployeeDeletion(
      int lastDeletedEmployeeId);

  Future<Either<CustomException, bool>> addOrUpdateEmployee(Employee employee);
}
