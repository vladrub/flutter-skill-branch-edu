import 'package:flutter/material.dart';
import 'package:galleryapp/res/colors.dart';
import 'package:galleryapp/res/res.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({this.onTap, this.label, Key key}) : super(key: key);

  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: 105,
          height: 36,
          color: AppColors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppStyles.h4.copyWith(color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
