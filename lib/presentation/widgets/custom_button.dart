import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    required this.btnText,
    this.backgroundColor,
    required this.onPressed,
    this.textBtnStyle,
    this.textColor,
    this.width,
    this.height,
    this.borderSide,
    this.svgPictureAsset,
    this.assetWidth,
    this.assetHeight,
    this.radius = 8
    // required this.fontWeight
  });
//height: 45.h,
//       width: 343.w,
  final Color? backgroundColor;
  final Color? textColor;
  // final FontWeight fontWeight;
  final TextStyle? textBtnStyle;
  final String btnText;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final BorderSide? borderSide;
  final String? svgPictureAsset;
  final double? assetWidth;
  final double? assetHeight;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            fixedSize: width != null && height != null? Size(width! ,height!) : Size(343.w ,45.h),
            foregroundColor: textColor,
            side: borderSide ?? BorderSide.none,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!.r)),
            elevation: 0,
            padding: EdgeInsets.zero
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // svgPictureAsset != null? SvgPicture.asset(svgPictureAsset!, width: assetWidth, height: assetHeight,) : const SizedBox(),
              svgPictureAsset != null? SizedBox(width: 8.w,) : const SizedBox.shrink(),
              Text(btnText, maxLines: 1,),
            ],
          ),
      ),
    );
  }
}