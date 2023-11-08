import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/app/route_names.dart';
import 'package:employee/domain/employee_repository.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:employee/view/providers/employees_list_provider.dart';
import 'package:employee/view/screen_args/add_edit_employee_screen_args.dart';
import 'package:employee/view/widgets/employee_list_tile.dart';
import 'package:employee/view/widgets/empty_list_info.dart';
import 'package:employee/view/widgets/list_heading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late EmployeesListProvider provider;

  @override
  void initState() {
    super.initState();
    provider = EmployeesListProvider(
      employeeRepository: context.read<EmployeeRepository>(),
    );
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmployeesListProvider>.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Employee List"),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          onPressed: () => _addOrEditEmployee(context),
          child: SvgPicture.asset(AppIcons.add),
        ),
        body: Consumer<EmployeesListProvider>(
          builder: (context, provider, child) {
            if (provider.isBusy) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (provider.hasError) {
              return Center(
                child: Text(
                    "Sorry!\nAn error occured when fetching employees\n${provider.error}"),
              );
            }
            if (provider.employees.isEmpty) {
              return const EmptyListInfo();
            }
            final expiredEmployees = provider.employees
                .where((emp) => emp.toDate?.isBefore(DateTime.now()) ?? false)
                .toList();
            final currentEmployees = provider.employees
                .where((emp) => emp.toDate?.isAfter(DateTime.now()) ?? true)
                .toList();
            return CustomScrollView(
              slivers: [
                if (currentEmployees.isNotEmpty)
                  SliverList.builder(
                    itemCount: currentEmployees.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const HeadingText(
                          headingText: "Current employees",
                        );
                      }
                      final employee = currentEmployees[index - 1];
                      return EmployeeListTile(
                        key: ValueKey<int>(employee.id!),
                        employee: employee,
                        isExpiredEmployee: false,
                        onDeleted: () => _deleteEmployee(employee),
                        onEditPressed: () =>
                            _addOrEditEmployee(context, employee),
                      );
                    },
                  ),
                if (expiredEmployees.isNotEmpty)
                  SliverList.builder(
                    itemCount: expiredEmployees.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const HeadingText(
                          headingText: "Previous employees",
                        );
                      }
                      final employee = expiredEmployees[index - 1];
                      return EmployeeListTile(
                        key: ValueKey<int>(employee.id!),
                        employee: employee,
                        isExpiredEmployee: true,
                        onDeleted: () => _deleteEmployee(employee),
                        onEditPressed: () =>
                            _addOrEditEmployee(context, employee),
                      );
                    },
                  ),
                SliverToBoxAdapter(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 12),
                      child: Text(
                        "Swipe left to delete",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _addOrEditEmployee(BuildContext context,
      [Employee? employee]) async {
    Map<String, dynamic> qp = {};
    if (employee != null) {
      qp = AddEditEmployeeScreenArgs.fromEmployee(employee).toJson();
    }
    final isDataChanged = await context.pushNamed<bool?>(RouteNames.addEmployee,
        queryParameters: qp);
    if ((isDataChanged ?? false) && mounted) {
      context.read<EmployeesListProvider>().refresh();
    }
  }

  void _deleteEmployee(Employee deletedEmployee) {
    provider.deleteEmployee(deletedEmployee);
    final snackbar = SnackBar(
      content: const Text("Employee data as been deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          provider.undoEmployeeDeletion(deletedEmployee);
        },
      ),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
