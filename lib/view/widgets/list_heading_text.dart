import 'package:employee/app/app_theme.dart';
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    required this.headingText,
  });

  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.centerLeft,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.grey,
      ),
      child: Text(
        headingText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.blue),
      ),
    );
  }
}
