import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isOutlined;
  final VoidCallback onPressed;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = isOutlined
        ? OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: Colors.black),
            foregroundColor: Colors.black,
          )
        : ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          );

    final buttonWidth = fullWidth
        ? double.infinity
        : (MediaQuery.of(context).size.width / 2) - 24;

    return SizedBox(
      width: fullWidth ? double.infinity : buttonWidth,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: Text(text, style: const TextStyle(fontSize: 16)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: Text(text, style: const TextStyle(fontSize: 16)),
            ),
    );
  }
}
