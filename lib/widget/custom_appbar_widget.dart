import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool? centerTitle;

  const CustomAppBar({
    Key? key,
    this.text,
    this.onBackPressed,
    this.actions,
    this.centerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text ?? ''),
      centerTitle: centerTitle ?? true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed ?? () => Get.back(),
      ),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}