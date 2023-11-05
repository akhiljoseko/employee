import 'package:employee/app/app_theme.dart';
import 'package:employee/view/providers/employees_list_provider.dart';
import 'package:employee/view/widgets/empty_list_info.dart';
import 'package:employee/view/widgets/list_heading_text.dart';
import 'package:flutter/material.dart';
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
        body: Consumer<EmployeesListProvider>(
          builder: (context, provider, child) {
            //TODO: Add error info if needed
            if (provider.isEmployeesListEmpty) {
              return const EmptyListInfo();
            }
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: 5 + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const HeadingText(
                        headingText: "Current employees",
                      );
                    }
                    return const ListTile(
                      title: Text("Test"),
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
                    return const ListTile(
                      title: Text("Test"),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
