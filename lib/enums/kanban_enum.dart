// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum KanbanEnum {
  @JsonValue(1)
  todo,
  @JsonValue(2)
  inProgress,
  @JsonValue(3)
  don,
}