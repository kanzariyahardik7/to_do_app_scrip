import 'package:app_scrip/utils/colors.dart';
import 'package:flutter/material.dart';

class InstructionBox extends StatelessWidget {
  const InstructionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: blueshade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blueAccent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: blue, size: 28),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "For a successful API response, you must use:\n\n"
              "📧 Email: eve.holt@reqres.in\n"
              "🔑 Password: pistol\n\n"
              "Any other values will return an error.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
