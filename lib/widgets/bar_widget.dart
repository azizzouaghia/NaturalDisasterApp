import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.font,
      title: Text(title),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
