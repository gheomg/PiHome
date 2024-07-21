import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final double value;
  final double maxValue;
  final Color valueColor;
  final Color inactiveColor;

  const SimpleBarChart({
    super.key,
    required this.value,
    required this.maxValue,
    required this.valueColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: (value * 100) / maxValue,
            height: 20,
            child: Container(
              color: valueColor,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 100,
            height: 20,
            child: Container(
              color: inactiveColor,
            ),
          ),
        ),
      ],
    );
  }
}
