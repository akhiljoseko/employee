import 'package:isar/isar.dart';

part 'employee_entity.g.dart';

@Collection()
class EmployeeEntity {
  Id id = Isar.autoIncrement;

  late String name;
  late int roleId;
  late String roleName;
  late DateTime fromDate;
  DateTime? toDate;
  late bool isDeleted;
}
