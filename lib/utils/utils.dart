import 'package:app_scrip/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: white,
      fontSize: 16.0,
    );
  }

  static showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: black,
        closeIconColor: black,
        showCloseIcon: true,
        content: Text("Press back again to exit"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static String formatDate(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      final date = DateTime.parse(isoString); // parse the ISO string
      return DateFormat('dd-MM-yyyy').format(date); // convert to 29-09-2025
    } catch (e) {
      return isoString; // fallback if parsing fails
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
