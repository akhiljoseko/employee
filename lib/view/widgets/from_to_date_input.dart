import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_icons.dart';
import 'inline_date_input.dart';

class FromToDateInput extends StatelessWidget {
  const FromToDateInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InlineDateInput(
            initialDate: DateTime.now(),
            onDateSelected: (DateTime date) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SvgPicture.asset(AppIcons.arrow_right),
        ),
        Expanded(
          child: TextFormField(
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
          ),
        ),
      ],
    );
  }
}
