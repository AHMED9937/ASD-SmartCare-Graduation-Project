import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:flutter/material.dart';

class AddChildForm extends StatelessWidget {
  const AddChildForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ParentSignUpCubit.get(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Form(
        key: cubit.addParentFormKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            AppTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your child name';
                }
                return null;
              },
              hint: 'Enter your Child Name',
              controller:
                  ParentSignUpCubit.get(context).ChildNametextcontroller,
              prefixIcon: Icons.person_rounded,
            ),
            const SizedBox(height: 20),
            AppTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your child Age';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Enter valid number';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              hint: 'Enter your child Age',
              controller: ParentSignUpCubit.get(context).ChildAgetextcontroller,
              prefixIcon: Icons.cake_rounded,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select child Gender';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surface,
                hintText: 'Select Gender',
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                prefixIcon: const Icon(
                  Icons.people_alt_rounded,
                  color: AppColors.primary,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppRadius.mdRadius,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.mdRadius,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.mdRadius,
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: AppRadius.mdRadius,
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.5,
                  ),
                ),
              ),
              dropdownColor: AppColors.surface,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary),
              items: const [
                DropdownMenuItem(
                  value: 'male',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'female',
                  child: Text('Female'),
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  ParentSignUpCubit.get(context)
                      .ChildGendertextcontroller
                      .text = val;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
