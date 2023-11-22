import 'package:flutter/material.dart';


import 'colors.dart';

class CustomSnackBar {
  static SnackBar showErrorSnackBar(String message,String color) {
    return SnackBar(

      backgroundColor:  color == 'danger' ? cutomColor().dangerColorBg : cutomColor().successColorBg,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: color == 'danger' ? cutomColor().dangerColorText : cutomColor().successColorText
        ),
      ),
      duration: Duration(seconds: 4),
      action: SnackBarAction(
        label: 'Close',
        textColor:  color == 'danger' ? cutomColor().dangerColorText : cutomColor().successColorText,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }
// ... another snackbar
}