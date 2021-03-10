import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

class PhotoButton extends StatelessWidget {
  const PhotoButton({this.onTap, this.label, Key key}) : super(key: key);

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
