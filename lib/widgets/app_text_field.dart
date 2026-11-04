import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const new({
    super.key,
    required this._controller,
    required this.labelText,
    this.extraLabelText,
    required this.hintText,
    required this.isPassword,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = .text,
    this.validator,
    required this.textInputAction,
  });

  final String labelText;
  final String? extraLabelText;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  final TextEditingController _controller;
  final bool isPassword;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: .w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            if (extraLabelText != null)
              Text(
                extraLabelText!,
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: .w400,
                  color: theme.colorScheme.onSurface,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          textInputAction: .next,
          maxLines: 1,
          decoration: InputDecoration(
            hint: Text(hintText),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: theme.colorScheme.surfaceContainer,
            enabledBorder: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: BorderSide(width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: BorderSide(width: 0.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: BorderSide(width: 0.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: .circular(20),
              borderSide: BorderSide(width: 0.5),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
