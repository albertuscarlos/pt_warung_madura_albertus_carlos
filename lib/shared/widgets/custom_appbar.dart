import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class CustomAppbar extends StatelessWidget {
  final String appbarTitle;
  final bool showSuffixIcon;
  const CustomAppbar({
    super.key,
    required this.appbarTitle,
    this.showSuffixIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 100,
      leadingWidth: 100,
      leading: Row(
        children: [
          Text(
            appbarTitle,
            style: Style.buttonTextStyle.copyWith(fontSize: 18),
          ),
        ],
      ),
      actions: [
        if (showSuffixIcon)
          const ImageIcon(
            AssetImage('assets/icons/search_icon.png'),
          )
      ],
    );
  }
}
