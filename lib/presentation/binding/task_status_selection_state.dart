abstract class TaskStatusSelectionState{}
class SelectionChanged extends TaskStatusSelectionState{
  int index;
  SelectionChanged({required this.index});
}