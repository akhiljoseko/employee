import 'package:dartz/dartz.dart';
import 'package:employee/app/errors.dart';
import 'package:employee/domain/models/employee.dart';

abstract class EmployeeRepository {
  Future<Either<CustomException, List<Employee>>> getEmployees();

  Future<Either<CustomException, bool>> deleteEmployee(
      Employee deletedEmployee);

  Future<Either<CustomException, bool>> undoEmployeeDeletion(
      Employee? lastDeletedEmployee);
}
