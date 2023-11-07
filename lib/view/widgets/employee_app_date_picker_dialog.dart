import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/utils/date_time_utils.dart';
import 'package:employee/view/widgets/save_and_cancel_buttons.dart';
import 'package:employee/view/widgets/space.dart';
import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:flutter_svg/flutter_svg.dart';

import 'calendar_date_picker.dart';

class EmployeeAppDatePickerDialog extends StatefulWidget {
  const EmployeeAppDatePickerDialog({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.currentDate,
    required this.onDateChanged,
    this.buttons = const [],
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? currentDate;
  final void Function(DateTime date) onDateChanged;

  final List<CalendarButtonData> buttons;

  @override
  State<EmployeeAppDatePickerDialog> createState() =>
      _EmployeeAppDatePickerDialogState();
}

class _EmployeeAppDatePickerDialogState
    extends State<EmployeeAppDatePickerDialog> {
  DateTime? _selectedDate;

  double get _gridHeight {
    final noOfButtonPairs = widget.buttons.length ~/ 2;
    return noOfButtonPairs * 44;
  }

  String get _formattedSelectedDate {
    if (_selectedDate == null) {
      return "No Date";
    } else {
      return DateTImeUtils.dateTimeCustomFormat(_selectedDate, "d MMM yyyy");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Vspace(12),
                if (widget.buttons.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      height: _gridHeight,
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 4.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          physics: const NeverScrollableScrollPhysics(),
                          children: widget.buttons
                              .map(
                                (data) => CustomDateButton(
                                  data: data,
                                  isSelected: false,
                                ),
                              )
                              .toList()),
                    ),
                  ),
                CalendarDatePicker(
                  initialDate: widget.initialDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  currentDate: widget.currentDate,
                  onDateChanged: widget.onDateChanged,
                ),
                const Divider(
                  color: AppColors.grey,
                  thickness: 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.calendar_outlined),
                          const Hspace(8),
                          Text(
                            _formattedSelectedDate,
                          )
                        ],
                      ),
                      const Spacer(),
                      SaveAndCancelButton(
                        onCancelPressed: () {
                          Navigator.of(context).pop();
                        },
                        onSavePressed: () {},
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDateButton extends StatelessWidget {
  const CustomDateButton({
    super.key,
    required this.isSelected,
    required this.data,
  });

  final bool isSelected;
  final CalendarButtonData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected
            ? AppColors.blue
            : AppColors.blue.withOpacity(
                .15,
              ),
      ),
      alignment: Alignment.center,
      child: Text(
        data.buttonName,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isSelected ? AppColors.white : AppColors.blue,
            ),
      ),
    );
  }
}

class CalendarButtonData {
  final String buttonName;
  final DateTime? dateToBeSelected;

  CalendarButtonData({
    required this.buttonName,
    required this.dateToBeSelected,
  });
}
