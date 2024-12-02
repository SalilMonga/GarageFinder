import 'package:flutter/material.dart';
import 'package:garagefinder/components/primary_button.dart';

class ParkingButtons extends StatelessWidget {
  final VoidCallback onFilterPressed;
  final VoidCallback onReservePressed;
  final String reserveButtonLabel;

  const ParkingButtons({
    super.key,
    required this.onFilterPressed,
    required this.onReservePressed,
    required this.reserveButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            text: 'Filter',
            onPressed: onFilterPressed,
            isOutlined: true, // Assuming `PrimaryButton` has an outlined style
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: reserveButtonLabel,
            onPressed: onReservePressed,
          ),
        ),
      ],
    );
  }
}
