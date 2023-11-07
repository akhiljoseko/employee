import 'package:employee/utils/date_time_utils.dart';
import 'package:employee/view/widgets/employee_app_date_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_icons.dart';

class InlineDateInput extends StatefulWidget {
  const InlineDateInput({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    required this.customCalendarButtons,
  });

  final DateTime? initialDate;
  final void Function(DateTime? date) onDateSelected;
  final List<CalendarButtonData> customCalendarButtons;

  @override
  State<InlineDateInput> createState() => _InlineDateInputState();
}

class _InlineDateInputState extends State<InlineDateInput> {
  late final TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
        text: DateTImeUtils.dateTimeCustomFormat(_selectedDate, "d MMM yyyy"));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      canRequestFocus: false,
      enableInteractiveSelection: false,
      readOnly: true,
      decoration: InputDecoration(
        label: const Text("No Date"),
        prefixIcon: SvgPicture.asset(
          AppIcons.calendar_outlined,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        prefixIconConstraints: BoxConstraints.tight(
          const Size(48, 24),
        ),
      ),
      onTap: _showDatePicker,
    );
  }

  void _showDatePicker() {
    showDialog<DateTime>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return EmployeeAppDatePickerDialog(
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          onDateSelected: _handleDateSelection,
          initialDate: _selectedDate,
          buttons: widget.customCalendarButtons,
        );
      },
    );
  }

  void _handleDateSelection(DateTime? date) {
    widget.onDateSelected.call(_selectedDate);
    _selectedDate = date;
    _controller.text =
        DateTImeUtils.dateTimeCustomFormat(_selectedDate, "d MMM yyyy");
  }
}
