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
    required this.onDateSelected,
    this.buttons = const [],
  });

  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? currentDate;
  final void Function(DateTime? date) onDateSelected;

  final List<CalendarButtonData> buttons;

  @override
  State<EmployeeAppDatePickerDialog> createState() =>
      _EmployeeAppDatePickerDialogState();
}

class _EmployeeAppDatePickerDialogState
    extends State<EmployeeAppDatePickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

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
    return Center(
      child: SingleChildScrollView(
        child: Padding(
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
                          child: Wrap(
                            children: widget.buttons
                                .map(
                                  (data) => _CustomDateButton(
                                    data: data,
                                    isSelected: DateUtils.isSameDay(
                                        _selectedDate, data.dateToBeSelected),
                                    onPressed: () => _handleDateSelection(
                                      data.dateToBeSelected,
                                    ),
                                  ),
                                )
                                .toList(),
                          )),
                    CalendarDatePicker(
                      initialDate: _selectedDate,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                      onDateChanged: _handleDateSelection,
                    ),
                    const Divider(
                      color: AppColors.grey,
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                              Navigator.pop(context);
                            },
                            onSavePressed: _handleDateSelectionConfirmation,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleDateSelection(DateTime? value) {
    _selectedDate = value;
    setState(() {});
  }

  void _handleDateSelectionConfirmation() {
    widget.onDateSelected.call(_selectedDate);
    Navigator.pop(context);
  }
}

class _CustomDateButton extends StatelessWidget {
  const _CustomDateButton({
    required this.isSelected,
    required this.data,
    required this.onPressed,
  });

  final bool isSelected;
  final CalendarButtonData data;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 36,
        width: 140,
        margin: const EdgeInsets.all(12),
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
