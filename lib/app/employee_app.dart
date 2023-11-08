import 'package:employee/app/app_router.dart';
import 'package:employee/app/app_theme.dart';
import 'package:flutter/material.dart';

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
