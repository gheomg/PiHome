import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? helperText;
  final bool? autocorrect;
  final bool? obscureText;
  final bool? enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.helperText,
    this.autocorrect,
    this.obscureText,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        labelText: label,
        prefixIcon: Icon(
          icon,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        helperText: helperText,
        helperStyle: const TextStyle(
          fontSize: 14,
        ),
        helperMaxLines: 3,
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(
                  Icons.cancel_outlined,
                ),
              )
            : null,
      ),
      keyboardType: keyboardType,
      autocorrect: autocorrect ?? true,
      obscureText: obscureText ?? false,
      enabled: enabled,
    );
  }
}
