import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String? title;
  final String? text;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final String? infoText;

  const InfoCard({
    super.key,
    required this.title,
    required this.text,
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.infoText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  icon,
                  size: 70,
                  color: iconColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      text ?? '',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    infoText ?? '',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
