import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/widgets/custom_input_field.dart';

class LoginFormSection extends StatelessWidget {
  final GlobalKey<FormState> authKey;
  final TextEditingController emailController, passwordController;
  final FocusNode emailFocus, passwordFocus;
  final ValueNotifier<bool> emailFocusNotifier,
      passwordFocusNotifier,
      obscurePasswordNotifier;
  const LoginFormSection({
    super.key,
    required this.authKey,
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.emailFocusNotifier,
    required this.passwordFocusNotifier,
    required this.obscurePasswordNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authKey,
      child: Column(
        children: [
          //Email Form
          CustomInputField(
            controller: emailController,
            focusNode: emailFocus,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            prefixIcon: ValueListenableBuilder<bool>(
              valueListenable: emailFocusNotifier,
              builder: (context, isFocused, child) => Icon(
                Icons.email,
                color:
                    isFocused ? Style.primaryColor : Style.textFieldIconColor,
              ),
            ),
            validator: (String? email) {
              if (email != null && email.isEmpty) {
                return 'Email cannot be empty.';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 17),
          //Password Form
          ValueListenableBuilder(
            valueListenable: obscurePasswordNotifier,
            builder: (context, isObscure, child) {
              return ValueListenableBuilder<bool>(
                valueListenable: passwordFocusNotifier,
                builder: (context, isFocused, child) => CustomInputField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: isFocused
                        ? Style.primaryColor
                        : Style.textFieldIconColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      obscurePasswordNotifier.value =
                          !obscurePasswordNotifier.value;
                    },
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: isFocused
                          ? Style.primaryColor
                          : Style.textFieldIconColor,
                    ),
                  ),
                  obscureText: isObscure,
                  validator: (String? password) {
                    if (password != null && password.isEmpty) {
                      return 'Password cannot be empty.';
                    } else {
                      return null;
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
