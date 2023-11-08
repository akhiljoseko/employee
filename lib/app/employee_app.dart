import 'package:employee/app/app_router.dart';
import 'package:employee/app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/employee_repository.dart';
import '../view/cubits/cubit/employees_list_cubit.dart';

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeesListCubit>(
      create: (context) => EmployeesListCubit(
        employeeRepository: context.read<EmployeeRepository>(),
      ),
      child: MaterialApp.router(
        theme: AppTheme().lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
