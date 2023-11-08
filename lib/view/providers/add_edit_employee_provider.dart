import 'package:employee/app/base_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:employee/domain/employee_repository.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:employee/domain/models/role.dart';
import 'package:employee/view/screen_args/add_edit_employee_screen_args.dart';

class AddEditEmployeeProvider extends BaseProvider {
  final AddEditEmployeeScreenArgs? args;
  final EmployeeRepository employeeRepository;

  AddEditEmployeeProvider({
    required this.args,
    required this.employeeRepository,
  }) {
    _isAdding = args?.id == null;
    if (!_isAdding) {
      _setVariblesWithData();
    }
  }

  late bool _isAdding;

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
      id: args?.id,
      name: name!,
      roleId: selectedRole!.id,
      roleName: selectedRole!.role,
      fromDate: fromDate!,
      toDate: toDate,
    );
    busy();
    final result = await employeeRepository.addOrUpdateEmployee(employee);
    idle();
    return result.fold((error) => false, (isAdded) => isAdded);
  }

  void _setVariblesWithData() {
    name = args?.name;
    selectedRole =
        Role.roles.firstWhereOrNull((element) => element.id == args?.roleId);
    fromDate = args?.fromDate;
    toDate = args?.toDate;
  }
}
