import 'package:employee/database/isar_employee_api.dart';
import 'package:employee/domain/employee_repository.dart';
import 'package:employee/domain/employee_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/employee_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarEmployeeApi.initApi();

  runApp(
    MultiProvider(
      providers: [
        Provider<EmployeeRepository>(
          create: (context) => EmployeeRepositoryImpl(
            employeeApi: IsarEmployeeApi(),
          ),
        )
      ],
      child: const EmployeeApp(),
    ),
  );
}
