import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/resources/app_colors.dart';
import 'package:task_management/core/resources/constants.dart';
import 'package:task_management/presentation/binding/task_status_Selection_cubit.dart';
import 'package:task_management/presentation/binding/task_status_selection_state.dart';

class SelectableTaskStatus extends StatelessWidget {
  const SelectableTaskStatus({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskStatusSelectionCubit, TaskStatusSelectionState>(
      builder: (BuildContext context, TaskStatusSelectionState state) { 
        return Row(
          children: List.generate(Constants.selectableItems.length, (index){
            return GestureDetector(
              onTap: () => BlocProvider.of<TaskStatusSelectionCubit>(context).changeSelection(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 18),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: (state as SelectionChanged).index == index? AppColors.lightGreenColor : AppColors.lightGreenColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(Constants.selectableItems[index], style: TextStyle(fontSize: 13.sp, color: state.index == index? AppColors.whiteColor : AppColors.lightGreenColor,),),
              ),
            );
          }),
        );
      },
    );
  }
}