import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int? id;
  final String name;
  final int roleId;
  final String roleName;
  final DateTime fromDate;
  final DateTime? toDate;

  const Employee(
      {this.id,
      required this.name,
      required this.roleId,
      required this.roleName,
      required this.fromDate,
      this.toDate});

  Employee copy() {
    return Employee(
      id: id,
      name: name,
      roleId: roleId,
      roleName: roleName,
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  @override
  List<Object?> get props => [id, name, roleId];
}
