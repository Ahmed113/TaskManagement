import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task_management/core/resources/app_colors.dart';
import 'package:task_management/domain/entities/task_entity.dart';
import 'package:task_management/presentation/binding/task_cubit.dart';
import 'package:task_management/presentation/binding/task_state.dart';

import '../../utility/picker_helper.dart';
import 'custom_button.dart';
import 'custom_text_form_feild.dart';

class CreateNewTaskBtmSheet extends StatelessWidget {
  CreateNewTaskBtmSheet({
    super.key,
  });

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final FocusNode _taskTitleFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: BlocListener<TaskCubit, TaskState>(
          listener: (BuildContext context, TaskState state) {
            switch(state.runtimeType) {
              case TaskLoading:
                isLoading = true;
                break;
              case TaskLoadingFailed:
                isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('There is something wrong'),
                  ),
                );
                break;
            }
          },
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            blur: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                // The bottom navigation bar shadow
                boxShadow:  [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.2),
                    spreadRadius: 4.r,
                    blurRadius: 10.r,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.clear, color: AppColors.redColor,))),
                  Text('Create New Task', style: TextStyle(fontSize: 15.sp, color: AppColors.blackColor, fontWeight: FontWeight.bold),),
                  SizedBox(height: 14.h,),
                  CustomTextFormField(
                    controller: taskTitleController,
                    focusNode: _taskTitleFocusNode,
                    hint: 'Task title',
                    filledColor: AppColors.greyColor.withOpacity(.2),
                    filled: true,
                    borderRadius: 10.r,
                  ),
                  SizedBox(height: 7.h,),
                  GestureDetector(
                    onTap: () {
                      _taskTitleFocusNode.unfocus();
                      PickerHelper().selectDate(context, dueDateController);
                    }, // Gesture detector for selecting date
                    child: AbsorbPointer(
                      absorbing: true,
                      child: CustomTextFormField(
                        controller: dueDateController,
                        hint: 'Due Date',
                        filledColor: AppColors.greyColor.withOpacity(.2),
                        filled: true,
                        borderRadius: 10.r,
                        enabled: false,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  CustomButton(btnText: 'Save Task', backgroundColor: AppColors.greenColor, textColor: AppColors.whiteColor, onPressed: (){
                    if (taskTitleController.text.isNotEmpty && dueDateController.text.isNotEmpty) {
                    TaskEntity task = TaskEntity(taskTitle: taskTitleController.text, dueDate: dueDateController.text);
                    BlocProvider.of<TaskCubit>(context).storeTask(task);
                    Navigator.pop(context);
                    BlocProvider.of<TaskCubit>(context).getTasks();
                    } else{
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter both task title and due date'),
                          backgroundColor: AppColors.redColor,
                        ),
                      );
                    }
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}