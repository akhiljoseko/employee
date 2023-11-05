import 'package:employee/app/route_names.dart';
import 'package:employee/view/screens/employee_list_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        name: RouteNames.employeeListScreen,
        path: "/",
        builder: (context, state) => const EmployeeListScreen(),
      )
    ],
  );
}
