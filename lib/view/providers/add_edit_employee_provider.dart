import 'package:employee/app/base_provider.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:employee/domain/models/role.dart';

class AddEditEmployeeProvider extends BaseProvider {
  String? name;
  void onNameChanged(String value) {
    name = value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter employee name";
    }
    return null;
  }

  Role? selectedRole;
  void onRoleSelected(Role role) {
    selectedRole = role;
  }

  String? validateRole(Role? value) {
    if (value == null) {
      return "Please select a role";
    }
    return null;
  }

  DateTime? fromDate;
  void onFromDateChanged(DateTime? value) {
    fromDate = value;
  }

  DateTime? toDate;
  void onToDateChanged(DateTime? value) {
    toDate = value;
  }

  String? validateFromDate(DateTime? value) {
    if (value == null) {
      return "Select date";
    }
    return null;
  }

  Future<bool> save() async {
    final employee = Employee(
      name: name!,
      roleId: selectedRole!.id,
      fromDate: fromDate!,
      toDate: toDate,
    );
    print(employee);
    return false;
  }
}
