import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget{
  const CustomTextFormField({super.key,
    this.controller,
    this.hint,
    this.filled,
    this.filledColor,
    this.borderRadius = 8,
    this.focusNode,
    this.enabled,
  });

  final TextEditingController? controller;
  final String? hint;
  final bool? filled;
  final Color? filledColor;
  final double borderRadius;
  final FocusNode? focusNode;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              filled: filled?? true,
              fillColor: filledColor,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))
              ),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 12.sp,),
            ),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleSmall,
            focusNode: focusNode,
            enabled: enabled,
          ),
        ],
      ),
    );
  }

}