import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/view/providers/add_edit_employee_provider.dart';
import 'package:employee/view/screen_args/add_edit_employee_screen_args.dart';
import 'package:employee/view/widgets/role_selection_input_field.dart';
import 'package:employee/view/widgets/save_and_cancel_buttons.dart';
import 'package:employee/view/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/from_to_date_input.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  const AddEditEmployeeScreen({
    super.key,
    required this.args,
  });

  final AddEditEmployeeScreenArgs args;

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  late AddEditEmployeeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = AddEditEmployeeProvider();
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddEditEmployeeProvider>.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Employee List"),
        ),
        body: Consumer<AddEditEmployeeProvider>(
          builder: (context, provider, child) => Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          const Vspace(16),
                          TextFormField(
                            initialValue: provider.name,
                            onChanged: provider.onNameChanged,
                            validator: provider.validateName,
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
                            selectedRole: provider.selectedRole,
                            validator: provider.validateRole,
                            onRoleSelected: provider.onRoleSelected,
                          ),
                          const Vspace(18),
                          FromToDateInput(
                            fromDate: provider.fromDate,
                            toDate: provider.toDate,
                            onFromDateSelected: provider.onFromDateChanged,
                            ontoDateSelected: provider.onToDateChanged,
                            fromDateValidator: provider.validateFromDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.grey))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: SaveAndCancelButton(
                    onCancelPressed: () => context.pop(),
                    onSavePressed: () => _saveDetails(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveDetails(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    final result = await provider.save();
    if (result == true && mounted) {
      context.pop(true);
    }
  }
}
