import 'package:cinema_customer_app/constant.dart';
import 'package:flutter/material.dart';

class HaveAcountOrNot extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTap;

  const HaveAcountOrNot({this.title, this.subTitle, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subTitle,
            style: TextStyle(
              color: kBackground,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
