import 'package:employee/view/widgets/empty_list_info.dart';
import 'package:flutter/material.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: const EmptyListInfo(),
    );
  }
}
