import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_cubit.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_state.dart';

class SessionForm extends StatefulWidget {
  final String parentId;

  const SessionForm({super.key, required this.parentId});

  @override
  State<SessionForm> createState() => _SessionFormState();
}

class _SessionFormState extends State<SessionForm> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  int? _sessionNumber;
  DateTime? _sessionDate;
  String? _statusOfSession;
  final List<String> _comments = [];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _sessionDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.onPrimary,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _sessionDate) {
      setState(() {
        _sessionDate = picked;
      });
    }
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _comments.add(text);
        _commentController.clear();
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_sessionDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a session date')),
        );
        return;
      }
      _formKey.currentState!.save();
      final result = {
        'parentId': widget.parentId,
        'session_number': _sessionNumber,
        'session_date': _sessionDate!.toIso8601String().split('T')[0],
        'statusOfSession': _statusOfSession,
        'comments': _comments,
      };
      context.read<RegisteredChildrenListCubit>().CreateSession(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      RegisteredChildrenListCubit,
      GetRegisteredChildrenListStates
    >(
      builder: (context, state) {
        if (state is CreatSessionLoadingStates) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: LoadingView(message: 'Creating session...'),
            ),
          );
        }

        if (state is CreatSessionSuccsessStates) {
          return _buildSuccessState();
        }

        if (state is CreatSessionFailedStates) {
          return _buildErrorState();
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Session Number',
                hint: 'Enter session number',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.format_list_numbered_rounded,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => _sessionNumber = int.tryParse(val!),
              ),
              const SizedBox(height: AppSpacing.md),
              _buildDatePickerField(),
              const SizedBox(height: AppSpacing.md),
              AppDropdownField<String>(
                label: 'Status of Session',
                hint: 'Select status',
                value: _statusOfSession,
                items: const ['done', 'coming'],
                prefixIcon: Icons.info_outline_rounded,
                onChanged: (val) => setState(() => _statusOfSession = val),
                validator: (val) => val == null ? 'Required' : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildCommentsSection(),
              const SizedBox(height: AppSpacing.xl),
              AppButton(label: 'Create Session', onPressed: _submit),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDatePickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session Date',
          style: AppTypography.labelMedium.copyWith(color: AppColors.onSurface),
        ),
        const SizedBox(height: AppSpacing.xs),
        InkWell(
          onTap: () => _pickDate(context),
          borderRadius: AppRadius.mdRadius,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.mdRadius,
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: AppSpacing.iconMd,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  _sessionDate == null
                      ? 'Select Date'
                      : _sessionDate!.toLocal().toString().split(' ')[0],
                  style: AppTypography.bodyMedium.copyWith(
                    color: _sessionDate == null
                        ? AppColors.textSecondary
                        : AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comments',
          style: AppTypography.labelMedium.copyWith(color: AppColors.onSurface),
        ),
        const SizedBox(height: AppSpacing.xs),
        ..._comments.map((c) => _buildCommentItem(c)),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _commentController,
                hint: 'Add a comment',
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            AppIconButton(
              icon: Icons.add_rounded,
              onPressed: _addComment,
              backgroundColor: AppColors.primary,
              iconColor: AppColors.onPrimary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentItem(String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.smRadius,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Text(comment, style: AppTypography.bodyMedium),
    );
  }

  Widget _buildSuccessState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 80,
              color: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Session Created!',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Create Another',
              onPressed: () =>
                  context.read<RegisteredChildrenListCubit>().reset(),
              icon: Icons.add_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Failed to create session',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Try Again',
              onPressed: () =>
                  context.read<RegisteredChildrenListCubit>().reset(),
              icon: Icons.refresh_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
