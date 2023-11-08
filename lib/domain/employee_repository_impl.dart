import 'dart:async';
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:employee/app/errors.dart';
import 'package:employee/domain/models/employee.dart';
import 'employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  @override
  Future<Either<CustomException, List<Employee>>> getEmployees() async {
    await Future.delayed(const Duration(seconds: 2));
    return Right([
      Employee(
          id: Random().nextInt(30),
          name: "Test",
          roleId: 2,
          fromDate: DateTime(2022, 10, 01)),
      Employee(
        id: Random().nextInt(30),
        name: "Test2",
        roleId: 2,
        fromDate: DateTime(2022, 10, 01),
        toDate: DateTime(2022, 10, 01),
      )
    ]);
  }

  @override
  Future<Either<CustomException, bool>> deleteEmployee(
      Employee deletedEmployee) async {
    return const Right(true);
  }

  @override
  Future<Either<CustomException, bool>> undoEmployeeDeletion(
      Employee? lastDeletedEmployee) async {
    return const Right(true);
  }

  @override
  Future<Either<CustomException, bool>> addOrUpdateEmployee(
      Employee employee) async {
    return const Right(false);
  }
}
