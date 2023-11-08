import 'package:employee/app/app_icons.dart';
import 'package:employee/app/app_theme.dart';
import 'package:employee/domain/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoleSelectionInputField extends StatefulWidget {
  const RoleSelectionInputField({
    super.key,
    required this.onRoleSelected,
    this.validator,
    this.selectedRole,
  });

  final void Function(Role role) onRoleSelected;
  final String? Function(Role? value)? validator;
  final Role? selectedRole;

  @override
  State<RoleSelectionInputField> createState() =>
      _RoleSelectionInputFieldState();
}

class _RoleSelectionInputFieldState extends State<RoleSelectionInputField> {
  late final TextEditingController _controller;
  Role? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.selectedRole;
    _controller = TextEditingController(text: _selectedRole?.role);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      canRequestFocus: false,
      enableInteractiveSelection: false,
      readOnly: true,
      validator: (s) => widget.validator?.call(_selectedRole),
      onTap: () => _openRoleSelectionBottomSheet(context),
      decoration: InputDecoration(
        label: const Text("Select role"),
        prefixIcon: SvgPicture.asset(
          AppIcons.work_outlined,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        prefixIconConstraints: BoxConstraints.tight(
          const Size(48, 24),
        ),
        suffixIcon: SvgPicture.asset(
          AppIcons.arrow_drop_down,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        suffixIconConstraints: BoxConstraints.tight(
          const Size(48, 24),
        ),
      ),
    );
  }

  _openRoleSelectionBottomSheet(BuildContext context) async {
    final selectedRole = await showModalBottomSheet<Role>(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return const _RoleSelectionBottomSheet();
      },
    );
    if (selectedRole != null) {
      _handleRoleSelection(selectedRole);
    }
  }

  void _handleRoleSelection(Role selectedRole) {
    _controller.text = selectedRole.role;
    _selectedRole = selectedRole;
    widget.onRoleSelected.call(selectedRole);
  }
}

class _RoleSelectionBottomSheet extends StatelessWidget {
  const _RoleSelectionBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: Role.roles
          .map(
            (role) => InkWell(
              onTap: () {
                Navigator.of(context).pop(role);
              },
              child: Container(
                height: 52,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.grey,
                      width: 2,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Text(
                  role.role,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
