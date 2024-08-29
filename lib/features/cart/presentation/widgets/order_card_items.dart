import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class OrderCardItems extends StatelessWidget {
  final bool showCloseButton;
  final String title;
  final String? bodyText;
  final Color bodyTextColor;
  final bool isLastRow;
  final bool isShowCounter;
  final TextStyle titleTextStyle;
  final int quantity;
  final void Function()? onPressed;
  final void Function()? onTapIncrease;
  final void Function()? onTapDecrease;

  const OrderCardItems({
    super.key,
    this.showCloseButton = false,
    this.title = '',
    this.bodyText,
    this.bodyTextColor = Style.fontColorBlack,
    this.isLastRow = false,
    this.isShowCounter = false,
    this.titleTextStyle = Style.poppinsFont,
    this.quantity = 0,
    this.onPressed,
    this.onTapDecrease,
    this.onTapIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!showCloseButton) const SizedBox(height: 10),
        Row(
          children: [
            if (showCloseButton)
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.close,
                  color: Style.deleteBtnColor,
                  size: 30,
                ),
              ),
            if (!showCloseButton)
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: titleTextStyle,
              ),
            if (!showCloseButton) const Expanded(child: SizedBox()),
            if (!showCloseButton && bodyText != null)
              Text(
                bodyText ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Style.poppinsFont.copyWith(color: bodyTextColor),
              ),
            if (!showCloseButton && isShowCounter)
              Container(
                height: 65,
                width: 100,
                decoration: BoxDecoration(
                  color: Style.counterBgColor,
                  border: Border.all(color: Style.counterBorderColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: InkWell(
                            onTap: onTapDecrease,
                            child: const Icon(Icons.remove, size: 20)),
                      ),
                    ),
                    Text('$quantity', style: Style.poppinsFont),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: InkWell(
                          onTap: onTapIncrease,
                          child: const Icon(Icons.add, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        if (!showCloseButton) const SizedBox(height: 10),
        if (!isLastRow)
          const Divider(thickness: 1.5, color: Style.dividerColor),
      ],
    );
  }
}
