import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_dialog.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const CustomDialog(
                isLoading: true,
                dialogBody: 'Signing Out...',
              );
            },
          );
        } else if (state is AuthFailure) {
          context.pop();
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                dialogTitle: 'An Error Occured',
                dialogBody: state.message,
              );
            },
          );
        } else if (state is UserSignedOut) {
          context.goNamed('login_page');
        }
      },
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Style.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Style.secondaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image(
                        height: 70,
                        width: 70,
                        image: const NetworkImage(
                          'https://static.vecteezy.com/system/resources/thumbnails/036/594/092/small_2x/man-empty-avatar-photo-placeholder-for-social-networks-resumes-forums-and-dating-sites-male-and-female-no-photo-images-for-unfilled-user-profile-free-vector.jpg',
                        ),
                        errorBuilder: (context, error, stackTrace) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Style.secondaryColor,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Albertus Carloson Fallo',
                  style: Style.headingInterStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Style.secondaryColor),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Style.deleteBtnColor,
            ),
            title: Text(
              'Logout',
              style: Style.rubikFont.copyWith(
                color: Style.deleteBtnColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              context.read<AuthBloc>().add(SignOut());
            },
          ),
        ],
      ),
    );
  }
}
