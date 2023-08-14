import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class GlobalSnackbar {
  static void showError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SvgIcon(
              icon: SvgIconData('assets/icons/impIcon.svg'),
              color: Color(0xFFAE2D3C),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Color(0xFFAE2D3C),
                  fontSize: 12,
                  fontFamily: 'MontserratMedium',
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color(0xFFAE2D3C)),
        ),
        backgroundColor: Color(0xFFEAD5D8),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom -
              100,
          right: 20,
          left: 20,
        ),
      ),
    );
  }
}
