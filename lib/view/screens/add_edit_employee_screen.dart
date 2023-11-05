import 'package:employee/app/app_icons.dart';
import 'package:employee/view/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  const AddEditEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const VGap(16),
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
              const VGap(18),
              TextFormField(
                canRequestFocus: false,
                onTap: _openRoleDropDown,
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
              ),
              const VGap(18),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Today"),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openRoleDropDown() {
    //TODO: Role drop down
    print("Role drop down");
  }
}
