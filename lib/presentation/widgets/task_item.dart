import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/resources/app_colors.dart';
import 'package:task_management/domain/entities/task_entity.dart';
import 'package:task_management/presentation/binding/task_cubit.dart';
import 'package:task_management/presentation/binding/task_state.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task, required this.onToggle,
  });

  final TaskEntity task;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (BuildContext context, TaskState state) {
        return Card(
          elevation: 9, // Adjust elevation for the shadow
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black.withOpacity(.8),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.taskTitle, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.black),),
                    SizedBox(height: 8.h,),
                    Row(
                      children: [
                        Text("Due Date:\t", style: TextStyle(fontSize: 12.sp, color: Colors.black),),
                        Text(task.dueDate, style: TextStyle(fontSize: 12.sp, color: Colors.black),),
                      ],
                    ),
                  ],
                ),
                const Spacer(flex: 1,),
                GestureDetector(
                  onTap: onToggle,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: task.isDone? AppColors.greenColor.withOpacity(.25) : AppColors.mintGreenColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Icon(Icons.done, size: 28.sp, color: task.isDone? AppColors.greenColor : AppColors.lightMintGreenColor,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}