import 'package:employee/app/app_images.dart';
import 'package:employee/view/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListInfo extends StatelessWidget {
  const EmptyListInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.empty_list_illustration,
            width: 260,
            height: 240,
            fit: BoxFit.fill,
          ),
          const Vspace(8),
          Text(
            "No employee records found",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
