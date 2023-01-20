import 'package:flutter/material.dart';
import 'package:kanban_board/providers/home_provider.dart';
import 'package:kanban_board/view_model/task_view_model.dart';

class TaskProvider extends ChangeNotifier {

  bool get editModeDescription => _editModeDescription;
  bool _editModeDescription = false;

  bool get editModeTitle => _editModeTitle;
  bool _editModeTitle = false;

  TextEditingController? _descriptionController;
  TextEditingController? _titleController;

  TextEditingController descriptionController(String? defaultValue){
    if(_descriptionController != null){
      return _descriptionController!;
    }
    _descriptionController = TextEditingController(text: defaultValue ?? "");
    return _descriptionController!;
  }

  TextEditingController titleController(String? defaultValue){
    if(_titleController != null){
      return _titleController!;
    }
    _titleController = TextEditingController(text: defaultValue ?? "");
    return _titleController!;
  }

  void showDescriptionEditMode(){
    _editModeDescription = true;
    notifyListeners();
  }
  void hideDescriptionEditMode(){
    _editModeDescription = false;
    notifyListeners();
  }

  void showTitleEditMode(){
    _editModeTitle = true;
    notifyListeners();
  }
  void hideTitleEditMode(){
    _editModeTitle = false;
    notifyListeners();
  }

  void saveDescription(HomeProvider homeProvider, TaskViewModel taskViewModel) {
    taskViewModel.description = _descriptionController?.text;
    homeProvider.updateItem(taskViewModel);
    hideDescriptionEditMode();
  }

  void saveTitle(HomeProvider homeProvider, TaskViewModel taskViewModel) {
    taskViewModel.title = _titleController?.text ?? "";
    homeProvider.updateItem(taskViewModel);
    hideTitleEditMode();
  }

}