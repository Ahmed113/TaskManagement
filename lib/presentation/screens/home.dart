import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/resources/app_colors.dart';
import 'package:task_management/domain/entities/task_entity.dart';
import 'package:task_management/presentation/binding/connectivity_cubit.dart';
import 'package:task_management/presentation/binding/task_cubit.dart';
import 'package:task_management/presentation/binding/task_state.dart';
import 'package:task_management/presentation/binding/task_status_Selection_cubit.dart';
import 'package:task_management/presentation/binding/task_status_selection_state.dart';
import 'package:task_management/presentation/widgets/custom_button.dart';
import 'package:task_management/utility/show_custom_bottom_sheet.dart';

import '../widgets/create_new_task_btm_sheet.dart';
import '../widgets/selectable_task_status.dart';
import '../widgets/task_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).getTasks();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<ConnectivityCubit, ConnectivityStatus>(

          listener: (BuildContext context, ConnectivityStatus state) {
            if (state == ConnectivityStatus.connected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Back online')),
              );
            } else if (state == ConnectivityStatus.disconnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You are offline')),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good Morning", style: TextStyle(fontSize: 30.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
                SizedBox(height: 10.h,),
                SelectableTaskStatus(),
                SizedBox(height: 10.h,),
                BlocBuilder<TaskStatusSelectionCubit, TaskStatusSelectionState>(
                  builder: (BuildContext context, TaskStatusSelectionState state) {
                    if ((state as SelectionChanged).index == 0) {
                      return Expanded(
                        child: BlocConsumer<TaskCubit, TaskState>(
                          listener: (BuildContext context, TaskState state) {
                            if (state is TaskUpdated) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Task "${state.task.taskTitle}" updated successfully!'),
                                ),
                              );
                            }
                          },
                          builder: (BuildContext context, TaskState state) {
                            switch (state.runtimeType) {
                              case TaskLoading:
                                return const Center(child: CircularProgressIndicator());
                              case TaskLoaded:
                                List<TaskEntity> tasks = (state as TaskLoaded).tasks;
                                return ListView.builder(
                                    itemCount: tasks.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return TaskItem(task: tasks[index],
                                        onToggle: () {
                                          BlocProvider.of<TaskCubit>(context).toggleTask(tasks[index]);
                                        },
                                      );
                                    });
                              case TaskLoadingFailed:
                                return Center(child: Text((state as TaskLoadingFailed).exp),);
                              default:
                                return const Text('Add your tasks here');
                            }
                          },
                        ),
                      );
                    } else if (state.index == 1) {
                      List<TaskEntity> notDoneTasks = context.read<TaskCubit>().notDoneTasks;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: notDoneTasks.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TaskItem(task: notDoneTasks[index],
                                onToggle: () {},
                              );
                            }),
                      );
                    } else if (state.index == 2) {
                      List<TaskEntity> doneTasks = context.read<TaskCubit>().doneTasks;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: doneTasks.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TaskItem(task: doneTasks[index],
                                onToggle: () {},
                              );
                            }),
                      );
                    } else{
                      return const Center(child: Text('Something went error'),);
                    }
                  },
                ),
                SizedBox(height: 10.h,),
                CustomButton(btnText: 'Create Task',
                  backgroundColor: AppColors.greenColor,
                  textColor: Colors.white,
                  onPressed: () {
                    showCustomBottomSheet(context: context,
                        isScrollable: true,
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery
                                .of(context)
                                .size
                                .width - 18.w
                        ),
                        child: CreateNewTaskBtmSheet());
                  },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




