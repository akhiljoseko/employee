import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:employee/app/errors.dart';
import 'package:employee/data/employee_api.dart';
import 'package:employee/domain/models/employee.dart';
import 'employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeApi employeeApi;

  EmployeeRepositoryImpl({required this.employeeApi});
  @override
  Future<Either<CustomException, List<Employee>>> getEmployees() async {
    try {
      final employees = await employeeApi.getEmployees();
      return Right(employees);
    } on DatabaseException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownException(e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> deleteEmployee(
      Employee deletedEmployee) async {
    try {
      final isDeleted = await employeeApi.deleteEmployee(deletedEmployee.id!);
      return Right(isDeleted);
    } on DatabaseException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownException(e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> undoEmployeeDeletion(
      Employee deletedEmployee) async {
    try {
      final isSuccess = await employeeApi.undoDelete(deletedEmployee.id!);
      return Right(isSuccess);
    } on DatabaseException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownException(e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> addOrUpdateEmployee(
      Employee employee) async {
    try {
      bool isSuccess = false;
      if (employee.id != null) {
        isSuccess = await employeeApi.updateEmployeeData(employee);
      } else {
        isSuccess = await employeeApi.addEmployee(employee);
      }
      return Right(isSuccess);
    } on DatabaseException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownException(e.toString()));
    }
  }
}
