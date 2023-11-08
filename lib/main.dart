import 'package:employee/domain/employee_repository.dart';
import 'package:employee/domain/employee_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/employee_app.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EmployeeRepository>(
          create: (context) => EmployeeRepositoryImpl(),
        )
      ],
      child: const EmployeeApp(),
    ),
  );
}
