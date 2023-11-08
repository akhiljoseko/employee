import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/app/route_names.dart';
import 'package:employee/domain/employee_repository.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:employee/view/cubits/cubit/employees_list_cubit.dart';
import 'package:employee/view/widgets/employee_list_tile.dart';
import 'package:employee/view/widgets/empty_list_info.dart';
import 'package:employee/view/widgets/list_heading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeesListCubit>(
      create: (context) => EmployeesListCubit(
        employeeRepository: context.read<EmployeeRepository>(),
      ),
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
          onPressed: () => _addEmployee(context),
          child: SvgPicture.asset(AppIcons.add),
        ),
        body: BlocBuilder<EmployeesListCubit, EmployeesListState>(
          builder: (context, state) {
            if (state.status == EmployeesListStateStatus.initial ||
                state.status == EmployeesListStateStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == EmployeesListStateStatus.failure) {
              return Center(
                child: Text(
                    "Sorry!\nAn error occured when fetching employees\n${state.error}"),
              );
            }
            if (state.status == EmployeesListStateStatus.success &&
                state.employees.isEmpty) {
              return const EmptyListInfo();
            }
            final expiredEmployees = state.employees
                .where((emp) => emp.toDate?.isBefore(DateTime.now()) ?? false)
                .toList();
            final currentEmployees = state.employees
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
                        onDeleted: () => _deleteEmployee(context, employee),
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
                      final employee = currentEmployees[index - 1];
                      return EmployeeListTile(
                        key: ValueKey<int>(employee.id!),
                        employee: employee,
                        isExpiredEmployee: true,
                        onDeleted: () => _deleteEmployee(context, employee),
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

  void _addEmployee(BuildContext context) {
    context.goNamed(RouteNames.addEmployee);
  }

  void _deleteEmployee(BuildContext context, Employee deletedEmployee) {
    print("Deleted");
    context.read<EmployeesListCubit>().deleteEmployee(deletedEmployee);
    final snackbar = SnackBar(
      content: Text("Employee data as been deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          context
              .read<EmployeesListCubit>()
              .undoEmployeeDeletion(deletedEmployee);
        },
      ),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
