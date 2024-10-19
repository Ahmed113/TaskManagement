import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/binding/task_status_selection_state.dart';

class TaskStatusSelectionCubit extends Cubit<TaskStatusSelectionState>{
  TaskStatusSelectionCubit():super(SelectionChanged(index: 0));

  int statusIndex = 0;
  void changeSelection(index){
    statusIndex = index;
    emit(SelectionChanged(index: index));
  }
}