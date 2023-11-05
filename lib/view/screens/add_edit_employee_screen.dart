import 'package:flutter/material.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  const AddEditEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Employee name"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
