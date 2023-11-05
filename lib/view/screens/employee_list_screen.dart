import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/app/route_names.dart';
import 'package:employee/view/providers/employees_list_provider.dart';
import 'package:employee/view/widgets/employee_list_tile.dart';
import 'package:employee/view/widgets/empty_list_info.dart';
import 'package:employee/view/widgets/list_heading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeesListProvider(),
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
        body: Consumer<EmployeesListProvider>(
          builder: (context, provider, child) {
            //TODO: Add error info if needed
            if (provider.isEmployeesListEmpty) {
              return const EmptyListInfo();
            }
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: 7 + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const HeadingText(
                        headingText: "Current employees",
                      );
                    }
                    return EmployeeListTile(
                      key: ValueKey<String>("cur$index"),
                      isExpiredEmployee: false,
                      onDeleted: _deleteEmployee,
                    );
                  },
                ),
                SliverList.builder(
                  itemCount: 5 + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const HeadingText(
                        headingText: "Previous employees",
                      );
                    }
                    return EmployeeListTile(
                      key: ValueKey<String>("exp$index"),
                      isExpiredEmployee: true,
                      onDeleted: _deleteEmployee,
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

  void _deleteEmployee() {
    //TODO: Delete employee
  }
}
