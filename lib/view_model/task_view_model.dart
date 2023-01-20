// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'task_view_model.g.dart';

@JsonSerializable()
class TaskViewModel {
  final String id;
  String title;
  int order;
  String? description;
  String? startDate;
  String? endDate;

  TaskViewModel({
    required this.id,
    required this.title,
    required this.order,
    this.description,
    this.startDate,
    this.endDate,
  });

  DateTime? get startDateTime =>
      (startDate != null) ? DateTime.parse(startDate ?? "") : null;

  DateTime? get endDateTime =>
      (endDate != null) ? DateTime.parse(endDate ?? "") : null;

  Duration? timeDiff(){
    if(startDateTime == null){
      return null;
    }

    return (endDateTime ?? DateTime.now()).difference(startDateTime!);
}

  factory TaskViewModel.fromJson(Map<String, dynamic> json) =>
      _$TaskViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskViewModelToJson(this);
}
