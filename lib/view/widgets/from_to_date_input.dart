import 'package:employee/view/widgets/employee_app_date_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_icons.dart';
import 'inline_date_input.dart';

class FromToDateInput extends StatelessWidget {
  const FromToDateInput({
    super.key,
    this.fromDate,
    this.toDate,
    required this.onFromDateSelected,
    required this.ontoDateSelected,
  });

  final DateTime? fromDate;
  final DateTime? toDate;

  final void Function(DateTime? fromDate) onFromDateSelected;
  final void Function(DateTime? toDate) ontoDateSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InlineDateInput(
            initialDate: fromDate,
            customCalendarButtons: _getCalendarButtons(true),
            onDateSelected: onFromDateSelected,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SvgPicture.asset(AppIcons.arrow_right),
        ),
        Expanded(
          child: InlineDateInput(
            initialDate: toDate,
            customCalendarButtons: _getCalendarButtons(false),
            onDateSelected: ontoDateSelected,
          ),
        ),
      ],
    );
  }

  List<CalendarButtonData> _getCalendarButtons(bool isFromDate) {
    if (isFromDate) {
      return [
        CalendarButtonData(
          buttonName: "Today",
          dateToBeSelected: DateTime.now(),
        ),
        CalendarButtonData(
          buttonName: "Next Monday",
          dateToBeSelected: _nextMonday,
        ),
        CalendarButtonData(
          buttonName: "Next Tuesday",
          dateToBeSelected: _nextTuesday,
        ),
        CalendarButtonData(
          buttonName: "After 1 week",
          dateToBeSelected: _dayAfterOneWeek,
        ),
      ];
    } else {
      return [
        CalendarButtonData(
          buttonName: "Today",
          dateToBeSelected: DateTime.now(),
        ),
        CalendarButtonData(
          buttonName: "No Date",
          dateToBeSelected: null,
        ),
      ];
    }
  }

  DateTime get _nextMonday {
    final today = DateTime.now();
    if (today.weekday == 1) return _sameDayOnNextWeek;
    int daysUntilNextMonday = (8 - today.weekday) % 7;
    return today.add(Duration(days: daysUntilNextMonday));
  }

  DateTime get _nextTuesday {
    final today = DateTime.now();
    if (today.weekday == 2) return _sameDayOnNextWeek;
    int daysUntilNextTuesday = (9 - today.weekday) % 7;
    return today.add(Duration(days: daysUntilNextTuesday));
  }

  DateTime get _sameDayOnNextWeek =>
      DateTime.now().add(const Duration(days: 7));
  DateTime get _dayAfterOneWeek => DateTime.now().add(const Duration(days: 8));
}
