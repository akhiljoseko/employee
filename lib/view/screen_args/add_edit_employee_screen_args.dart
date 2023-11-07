import 'dart:math';

import 'package:employee/domain/models/employee.dart';

class AddEditEmployeeScreenArgs {
  final int? id;
  final String? name;
  final int? roleId;
  final DateTime? fromDate;
  final DateTime? toDate;

  AddEditEmployeeScreenArgs({
    this.id,
    this.name,
    this.roleId,
    this.fromDate,
    this.toDate,
  });

  factory AddEditEmployeeScreenArgs.fromEmployee(Employee employee) {
    return AddEditEmployeeScreenArgs(
      id: employee.id,
      name: employee.name,
      roleId: employee.roleId,
      fromDate: employee.fromDate,
      toDate: employee.toDate,
    );
  }

  factory AddEditEmployeeScreenArgs.fromJson(Map<String, dynamic> json) {
    return AddEditEmployeeScreenArgs(
      id: int.tryParse(json['id']),
      name: json['name'],
      roleId: int.tryParse(json['roleId']),
      fromDate: DateTime.tryParse(json['fromDate']),
      toDate: DateTime.tryParse(json['toDate']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = "$id";
    data['name'] = name;
    data['roleId'] = "$roleId";
    data['fromDate'] = fromDate.toString();
    data['toDate'] = toDate.toString();
    return data;
  }
}
