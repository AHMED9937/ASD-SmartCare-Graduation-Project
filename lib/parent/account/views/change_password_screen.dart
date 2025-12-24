import 'package:asdsmartcare/parent/account/controllers/change_password_cubit.dart';
import 'package:asdsmartcare/parent/account/controllers/change_password_state.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  final bool isParent;
  const ChangePasswordScreen({super.key, required this.isParent});

  InputDecoration _decoration({
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: toggle,
      ),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChanagePasswordCubit(),
      child: BlocConsumer<ChanagePasswordCubit, ChanagePasswordStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final ChanagePasswordCubit cubit = ChanagePasswordCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            appBar: const AppHeader(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageHeader(
                      title: 'Change Password',
                      subtitle:
                          'Update your password to keep your account secure.',
                    ),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.xl),
                          Image.asset(
                            'lib/appassets/images/logo1.png',
                            width: 121,
                            height: 99,
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // white form
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 32),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Form(
                              child: Column(
                                children: [
                                  // CURRENT
                                  ValueListenableBuilder<bool>(
                                    valueListenable: cubit.obscureCurrent,
                                    builder: (_, obscure, __) {
                                      return TextFormField(
                                        controller: cubit.currentController,
                                        obscureText: obscure,
                                        decoration: _decoration(
                                          hint: 'Enter your current password',
                                          obscure: obscure,
                                          toggle: () => cubit
                                              .obscureCurrent.value = !obscure,
                                        ),
                                        validator: (v) => (v ?? '').isEmpty
                                            ? 'Please enter your current password'
                                            : null,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // NEW
                                  ValueListenableBuilder<bool>(
                                    valueListenable: cubit.obscureNew,
                                    builder: (_, obscure, __) {
                                      return TextFormField(
                                        controller: cubit.newController,
                                        obscureText: obscure,
                                        decoration: _decoration(
                                          hint: 'Enter your new password',
                                          obscure: obscure,
                                          toggle: () =>
                                              cubit.obscureNew.value = !obscure,
                                        ),
                                        validator: (v) {
                                          if ((v ?? '').isEmpty) {
                                            return 'Please enter a new password';
                                          }
                                          if (v!.length < 6) {
                                            return 'Password must be at least 6 chars';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // CONFIRM
                                  ValueListenableBuilder<bool>(
                                    valueListenable: cubit.obscureConfirm,
                                    builder: (_, obscure, __) {
                                      return TextFormField(
                                        controller: cubit.confirmController,
                                        obscureText: obscure,
                                        decoration: _decoration(
                                          hint: 'Enter your confirm password',
                                          obscure: obscure,
                                          toggle: () => cubit
                                              .obscureConfirm.value = !obscure,
                                        ),
                                        validator: (v) {
                                          if ((v ?? '').isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          if (v != cubit.newController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 32),

                                  // BUTTON + loading
                                  BlocConsumer<ChanagePasswordCubit,
                                      ChanagePasswordStates>(
                                    listener: (ctx, state) {
                                      if (state
                                          is ChanagePasswordSuccsessStates) {
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Password changed!')),
                                        );
                                        Navigator.of(ctx).pop();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/login',
                                            (route) => false);
                                      }
                                      if (state
                                          is ChanagePasswordFailedStates) {
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Failed to change password')),
                                        );
                                      }
                                    },
                                    builder: (ctx, state) {
                                      final isLoading =
                                          state is ChanagePasswordLoadingStates;
                                      return SizedBox(
                                        width: double.infinity,
                                        height: 57,
                                        child: ElevatedButton(
                                          onPressed: isLoading
                                              ? null
                                              : () {
                                                  if (cubit
                                                      .formKey.currentState!
                                                      .validate()) {
                                                    ChanagePasswordCubit.get(
                                                            ctx)
                                                        .changePassword(
                                                      IsParent: isParent,
                                                      currentPassword: cubit
                                                          .currentController
                                                          .text,
                                                      newPassword: cubit
                                                          .newController.text,
                                                      confirmPassword: cubit
                                                          .confirmController
                                                          .text,
                                                    );
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF133E87),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: isLoading
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text(
                                                  'Change Password',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
