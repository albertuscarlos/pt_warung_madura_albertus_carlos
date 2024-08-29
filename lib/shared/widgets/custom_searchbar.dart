import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onTapSuffixIcon;
  final void Function(PointerDownEvent event)? onTapOutside;
  final void Function(String value)? onSubmitted;
  final void Function(String valuie)? onChanged;

  const CustomSearchBar({
    super.key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onTapSuffixIcon,
    this.onTapOutside,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onTapOutside: (val) => focusNode?.unfocus(),
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      cursorColor: Style.primaryColor,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hintText ?? 'Search Product',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Style.textFieldPlaceholderStyle,
              ),
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
          borderSide: BorderSide(
            color: Color(0xFFCBCBCB),
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
          borderSide: BorderSide(
            color: Color(0xFFCBCBCB),
            width: 1,
          ),
        ),
      ),
    );
  }
}
