import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/view/widgets/role_selection_input_field.dart';
import 'package:employee/view/widgets/save_and_cancel_buttons.dart';
import 'package:employee/view/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/from_to_date_input.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  const AddEditEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const Vspace(16),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Employee name"),
                        prefixIcon: SvgPicture.asset(
                          AppIcons.person_outlined,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                        prefixIconConstraints: BoxConstraints.tight(
                          const Size(48, 24),
                        ),
                      ),
                    ),
                    const Vspace(18),
                    RoleSelectionInputField(
                      onRoleSelected: (role) {},
                    ),
                    const Vspace(18),
                    FromToDateInput(
                      onFromDateSelected: (fromDate) {},
                      ontoDateSelected: (toDate) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.grey))),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SaveAndCancelButton(
              onCancelPressed: () {},
              onSavePressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
