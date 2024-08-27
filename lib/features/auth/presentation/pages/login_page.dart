import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_elevated_button.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/widgets/login_form_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController, passwordController;
  late FocusNode emailFocus, passwordFocus;
  late ValueNotifier<bool> emailFocusNotifier,
      passwordFocusNotifier,
      obscurePasswordNotifier;
  final GlobalKey<FormState> authKey = GlobalKey<FormState>();

  void _handleEmailFocus() {
    if (emailFocus.hasFocus) {
      emailFocusNotifier.value = true;
    } else {
      emailFocusNotifier.value = false;
    }
  }

  void _handlePasswordFocus() {
    if (passwordFocus.hasFocus) {
      passwordFocusNotifier.value = true;
    } else {
      passwordFocusNotifier.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    //Initialize controller
    emailController = TextEditingController();
    passwordController = TextEditingController();

    //Initialize FocusNode
    emailFocus = FocusNode();
    passwordFocus = FocusNode();

    //Initialize ValueListenable
    emailFocusNotifier = ValueNotifier(false);
    passwordFocusNotifier = ValueNotifier(false);
    obscurePasswordNotifier = ValueNotifier(true);

    //Initialize Focus Controller
    emailFocus.addListener(_handleEmailFocus);
    passwordFocus.addListener(_handlePasswordFocus);
  }

  @override
  void dispose() {
    super.dispose();
    //Dispose controller and focus node to avoid memory leak
    //Dispose controller
    emailController.dispose();
    passwordController.dispose();

    //Dispose focus node
    emailFocus.dispose();
    passwordFocus.dispose();

    //Dispose focus listener
    emailFocus.removeListener(_handleEmailFocus);
    passwordFocus.removeListener(_handlePasswordFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Style.primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      const Text(
                        'Login',
                        style: Style.headingInterStyle,
                      ),
                      const SizedBox(height: 23),
                      LoginFormSection(
                        authKey: authKey,
                        emailController: emailController,
                        passwordController: passwordController,
                        emailFocus: emailFocus,
                        passwordFocus: passwordFocus,
                        emailFocusNotifier: emailFocusNotifier,
                        passwordFocusNotifier: passwordFocusNotifier,
                        obscurePasswordNotifier: obscurePasswordNotifier,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          btnText: 'Masuk',
                          onPressed: () {
                            if (authKey.currentState?.validate() ?? false) {
                              log('Pressed');
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
