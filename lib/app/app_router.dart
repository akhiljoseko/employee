import 'package:employee/app/route_names.dart';
import 'package:employee/view/screens/add_edit_employee_screen.dart';
import 'package:employee/view/screens/employee_list_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        name: RouteNames.employeeListScreen,
        path: "/",
        builder: (context, state) => const EmployeeListScreen(),
        routes: [
          GoRoute(
            name: RouteNames.addEmployee,
            path: "add",
            builder: (context, state) => const AddEditEmployeeScreen(),
          ),
        ],
      ),
    ],
  );
}
