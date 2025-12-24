import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/account/controllers/edit_profile_cubit.dart';
import 'package:asdsmartcare/parent/account/controllers/edit_profile_state.dart';
import 'package:asdsmartcare/parent/my_children/views/edit_child_screen.dart';
import 'package:asdsmartcare/parent/account/views/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditParentProfileBody extends StatelessWidget {
  final EditParentProfileCubit cubit;
  final EditParentProfileState state;
  final String? originalImageUrl;
  final String parentId;

  const EditParentProfileBody({
    super.key,
    required this.cubit,
    required this.state,
    required this.originalImageUrl,
    required this.parentId,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Personal Information'),
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
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionHeader(title: 'Contact Details'),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      _buildTextField(
                        label: 'Email',
                        controller: cubit.emailCtrl,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildTextField(
                        label: 'Phone Number',
                        controller: cubit.phoneCtrl,
                        icon: Icons.phone_android_rounded,
                        keyboardType: TextInputType.phone,
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
                const SectionHeader(title: 'Account Settings'),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _ActionTile(
                        icon: Icons.lock_outline_rounded,
                        label: 'Change Password',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const ChangePasswordScreen(isParent: true),
                            ),
                          );
                        },
                      ),
                      const AppDivider(indent: 52),
                      _ActionTile(
                        icon: Icons.child_care_rounded,
                        label: 'Manage Children',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditChildScreen(parentId: parentId),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                AppButton(
                  label: 'Save Changes',
                  isLoading: state is EditParentProfileLoadingState,
                  onPressed: cubit.editParentProfile,
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
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
                'Change Profile Photo',
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

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(label, style: AppTypography.bodyLarge),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }
}
