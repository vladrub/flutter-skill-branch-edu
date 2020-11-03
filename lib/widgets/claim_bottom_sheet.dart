import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  const ClaimBottomSheet({Key key}) : super(key: key);

  static const claims = ['adult', 'harm', 'bully', 'spam', 'copyright', 'hate'];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.mercury,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: claims.map((claim) => _buildClaim(context, claim)).toList(),
        ),
      ),
    );
  }

  Widget _buildClaim(context, claim) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context, claim),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            claim.toUpperCase(),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
