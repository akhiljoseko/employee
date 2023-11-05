import 'package:employee/view/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile({
    super.key,
    required this.isExpiredEmployee,
    required this.onDeleted,
  });

  final bool isExpiredEmployee;
  final VoidCallback onDeleted;

  String get _timeRange {
    if (isExpiredEmployee) {
      return "21 Sep, 2022 - 1 Jan, 2023";
    } else {
      return "From 21 Sep, 2022";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
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
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Samantha Lee",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const VGap(10),
              Text(
                "Full stack developer",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const VGap(10),
              Text(
                _timeRange,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
