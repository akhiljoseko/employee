import 'package:employee/app/route_names.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:employee/utils/date_time_utils.dart';
import 'package:employee/view/screen_args/add_edit_employee_screen_args.dart';
import 'package:employee/view/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile({
    super.key,
    required this.isExpiredEmployee,
    required this.onDeleted,
    required this.employee,
  });

  final Employee employee;
  final bool isExpiredEmployee;
  final VoidCallback onDeleted;

  String get _timeRange {
    if (isExpiredEmployee) {
      return "${DateTImeUtils.dateTimeCustomFormat(employee.fromDate, "d MMM, yyyy")} - ${DateTImeUtils.dateTimeCustomFormat(employee.toDate, "d MMM, yyyy")}";
    } else {
      return "From ${DateTImeUtils.dateTimeCustomFormat(employee.fromDate, "d MMM, yyyy")}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: onDeleted,
        ),
        children: [
          SlidableAction(
            onPressed: (context) => onDeleted,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _editEmployee(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Vspace(10),
                Text(
                  "Full stack developer",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Vspace(10),
                Text(
                  _timeRange,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editEmployee(BuildContext context) {
    final qp = AddEditEmployeeScreenArgs.fromEmployee(employee).toJson();
    context.goNamed(RouteNames.addEmployee, queryParameters: qp);
  }
}
