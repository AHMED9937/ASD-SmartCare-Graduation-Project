import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/signup/views/widgets/parent_signup_body.dart';
import 'package:asdsmartcare/shared/auth/verification/views/email_verification_screen.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentSignUpScreen extends StatelessWidget {
  final ParentSignUpCubit? cubit;
  const ParentSignUpScreen({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit ?? ParentSignUpCubit(),
      child: BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
        listener: (context, state) {
          if (state is ParentSignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.success,
                content: Text('Account Created Successfully!'),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Emailverfcationscreen(
                        parentID: state.lum.data.id,
                        parentUserName: state.lum.data.userName,
                        parentEmail: state.lum.data.email,
                      )),
            );
          } else if (state is ParentSignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.error,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return const Scaffold(
            appBar: AppHeader.transparent(),
            body: SafeArea(
              child: ParentSignupBody(),
            ),
          );
        },
      ),
    );
  }
}
