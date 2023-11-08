import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int? id;
  final String name;
  final int roleId;
  final DateTime fromDate;
  final DateTime? toDate;

  const Employee(
      {this.id,
      required this.name,
      required this.roleId,
      required this.fromDate,
      this.toDate});

  Employee copyWith() {
    return Employee(
      id: id,
      name: name,
      roleId: roleId,
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  @override
  List<Object?> get props => [id, name, roleId];
}
