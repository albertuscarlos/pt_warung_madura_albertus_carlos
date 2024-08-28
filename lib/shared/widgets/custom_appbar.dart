import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class CustomAppbar extends StatelessWidget {
  final String appbarTitle;
  const CustomAppbar({
    super.key,
    required this.appbarTitle,
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
      actions: const [
        ImageIcon(
          AssetImage('assets/icons/search_icon.png'),
        )
      ],
    );
  }
}
