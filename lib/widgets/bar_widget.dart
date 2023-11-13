import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BarWidget extends StatelessWidget implements PreferredSizeWidget {
  const BarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.font,
      title: const Text("Dashboard Statistics"),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
