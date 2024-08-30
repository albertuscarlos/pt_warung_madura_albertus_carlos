import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class CustomAppbar extends StatelessWidget {
  final String appbarTitle;
  final bool showSuffixIcon;
  final void Function()? onTapSuffix;
  final bool isSuffixTapped;
  final void Function()? onTapFilter;
  const CustomAppbar({
    super.key,
    required this.appbarTitle,
    this.showSuffixIcon = true,
    this.onTapSuffix,
    this.onTapFilter,
    this.isSuffixTapped = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 100,
      leadingWidth: 200,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: Scaffold.of(context).openDrawer,
            child: const Icon(Icons.menu, size: 28),
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            appbarTitle,
            style: Style.buttonTextStyle.copyWith(fontSize: 18),
          ),
        ],
      ),
      actions: [
        if (showSuffixIcon)
          InkWell(
            onTap: onTapFilter,
            child: const Icon(Icons.filter_alt_outlined, size: 27),
          ),
        if (showSuffixIcon) const SizedBox(width: 20),
        if (showSuffixIcon)
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTapSuffix,
            child: isSuffixTapped
                ? const Icon(
                    Icons.search_off_outlined,
                    size: 30,
                    color: Style.deleteBtnColor,
                  )
                : const ImageIcon(
                    AssetImage(
                      'assets/icons/search_icon.png',
                    ),
                  ),
          ),
      ],
    );
  }
}
