import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable OTP input field using a single hidden text field.
/// This ensures consistent keyboard behavior (including backspace/delete).
class AppOtpField extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  final ValueChanged<String>? onCodeChanged;
  final int numberOfFields;
  final bool hasError;

  const AppOtpField({
    super.key,
    required this.onSubmit,
    this.onCodeChanged,
    this.numberOfFields = 4,
    this.hasError = false,
  });

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _shakeController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shakeController.reset();
        }
      });

    // Auto-focus after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void didUpdateWidget(AppOtpField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasError && !oldWidget.hasError) {
      _shakeController.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (value.length > widget.numberOfFields) {
      value = value.substring(0, widget.numberOfFields);
      _controller.text = value;
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: value.length));
    }

    // Trigger rebuild to update visual boxes
    setState(() {});

    widget.onCodeChanged?.call(value);

    if (value.length == widget.numberOfFields) {
      widget.onSubmit(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              _shakeAnimation.value *
                  (3 *
                      (0.5 -
                              (0.5 *
                                  (_shakeController.value * 20 -
                                      (_shakeController.value * 20).floor())))
                          .abs()),
              0), // Simple shake math or standard sine
          // Cleaner shake using sine:
          // offset: Offset(sin(_shakeController.value * pi * 4) * 10, 0),
          child: child,
        );
      },
      child: SizedBox(
        width: widget.numberOfFields * 65.0,
        height: 60,
        child: Stack(
          children: [
            // 1. Visual Layer (The Boxes)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.numberOfFields, (index) {
                return _buildDigitBox(index);
              }),
            ),

            // 2. Input Layer (Hidden TextField)
            Positioned.fill(
              child: Opacity(
                opacity: 0.0,
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: widget.numberOfFields,
                  onChanged: _onChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  showCursor: false,
                  enableInteractiveSelection: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDigitBox(int index) {
    final String text = _controller.text;
    final bool isFilled = index < text.length;
    final String char = isFilled ? text[index] : '';
    final bool isFocused = index == text.length;

    final borderColor = widget.hasError
        ? AppColors.error
        : (isFocused || isFilled
            ? AppColors.primary
            : AppColors.primaryDark.withValues(alpha: 0.2));

    final borderWidth = isFocused || widget.hasError ? 2.0 : 1.5;

    return Container(
      width: 55,
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: (isFocused || widget.hasError)
            ? [
                BoxShadow(
                  color: (widget.hasError ? AppColors.error : AppColors.primary)
                      .withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
