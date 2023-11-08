import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/domain/models/employee.dart';
import 'package:employee/utils/date_time_utils.dart';
import 'package:employee/view/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile({
    super.key,
    required this.isExpiredEmployee,
    required this.onDeleted,
    required this.employee,
    required this.onEditPressed,
  });

  final Employee employee;
  final bool isExpiredEmployee;
  final VoidCallback onDeleted;
  final VoidCallback onEditPressed;

  String get _timeRange {
    if (isExpiredEmployee) {
      return "${DateTImeUtils.dateTimeCustomFormat(employee.fromDate, "d MMM, yyyy")} - ${DateTImeUtils.dateTimeCustomFormat(employee.toDate, "d MMM, yyyy")}";
    } else {
      return "From ${DateTImeUtils.dateTimeCustomFormat(employee.fromDate, "d MMM, yyyy")}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        padding: const EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        color: AppColors.red,
        child: SvgPicture.asset(AppIcons.delete_outlined),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        color: AppColors.red,
        child: SvgPicture.asset(AppIcons.delete_outlined),
      ),
      onDismissed: (d) => onDeleted.call(),
      key: ObjectKey(employee),
      child: InkWell(
        onTap: onEditPressed, // () => _editEmployee(context),
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
                  employee.roleName,
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
}
