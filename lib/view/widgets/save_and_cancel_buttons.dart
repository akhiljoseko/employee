import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import 'space.dart';

class SaveAndCancelButton extends StatelessWidget {
  const SaveAndCancelButton({
    super.key,
    required this.onCancelPressed,
    required this.onSavePressed,
  });

  final VoidCallback onCancelPressed;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onCancelPressed,
          style: TextButton.styleFrom(
            fixedSize: const Size(75, 40),
            foregroundColor: AppColors.blue,
            backgroundColor: AppColors.blue.withOpacity(.12),
          ),
          child: const Text("Cancel"),
        ),
        const Hspace(16),
        ElevatedButton(
          onPressed: onSavePressed,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(75, 40),
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.blue,
          ),
          child: const Text("Save"),
        ),
      ],
    );
  }
}
