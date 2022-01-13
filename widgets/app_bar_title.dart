import 'package:flutter/material.dart';
import 'package:google_login_example/res/custom_colors.dart';

// 회원 가입 완료 후 최종 화면 앱 바

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '동계현장실습',
          style: TextStyle(
            color: CustomColors.firebaseWhite,
          ),
        ),
      ],
    );
  }
}