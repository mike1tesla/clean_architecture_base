import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? title;
  final bool hideBack;
  final Widget? action;

  const BasicAppBar({super.key, this.title, this.hideBack = false, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: title,
      actions: [action ?? Container()],
      leading: hideBack ? null : IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: IconButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.1),
          minimumSize: const Size(35, 35)
        ),
        icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 15),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
