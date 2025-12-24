import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/account/controllers/edit_profile_cubit.dart';
import 'package:asdsmartcare/doctor/account/controllers/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDoctorProfileBody extends StatelessWidget {
  final EditDoctorProfileCubit cubit;
  final EditDoctorProfileState state;
  final String? originalImageUrl;

  const EditDoctorProfileBody({
    super.key,
    required this.cubit,
    required this.state,
    required this.originalImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // --- HEADER SECTION ---
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                height: 220,
                width: double.infinity,
              ),
              EditableProfileAvatar(
                imageUrl: originalImageUrl,
                pickedImage: cubit.pickedImage,
                radius: 64,
                onTap: () => _showImageSourceActionSheet(context),
              ),
            ],
          ),

          // --- FORM SECTION ---
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Personal Details'),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Full Name',
                          controller: cubit.nameCtrl,
                          icon: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildTextField(
                          label: 'Age',
                          controller: cubit.ageCtrl,
                          icon: Icons.cake_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildTextField(
                          label: 'Address',
                          controller: cubit.addressCtrl,
                          icon: Icons.location_on_outlined,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const SectionHeader(title: 'Professional Profile'),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Specialization',
                          controller: cubit.DepartmentCtrl,
                          icon: Icons.medical_services_outlined,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildTextField(
                          label: 'Qualifications',
                          controller: cubit.qualificationsCtrl,
                          icon: Icons.workspace_premium_outlined,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildTextField(
                          label: 'Session Price (\$)',
                          controller: cubit.SessionPriceCtrl,
                          icon: Icons.payments_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  AppButton(
                    label: 'Save Changes',
                    isLoading: state is EditDoctorProfileLoadingState,
                    onPressed: cubit.editDoctorProfile,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (v) =>
          v == null || v.isEmpty ? 'This field is required' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide:
              BorderSide(color: AppColors.disabled.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide:
              BorderSide(color: AppColors.disabled.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text(
                'Update Profile Image',
                style: AppTypography.titleLarge,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.of(context).pop();
                cubit.pickPhoto(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                cubit.pickPhoto(ImageSource.gallery);
              },
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
