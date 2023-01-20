import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:kanban_board/enums/routes.dart';
import 'package:kanban_board/view_model/kanban_view_model.dart';
import 'package:kanban_board/view_model/user_data_view_model.dart';

class FirebaseDatabaseService {
  static FirebaseDatabase? _database;
  static final FirebaseDatabaseService _instance =
      FirebaseDatabaseService._internal();

  factory FirebaseDatabaseService() {
    return _instance;
  }

  FirebaseDatabaseService._internal();

  Future<void> init() async {
    _database = FirebaseDatabase.instance;
    _database?.setLoggingEnabled(kDebugMode);
  }

  Future<List<KanbanViewModel>> getUserData(String? userId) async {
    DatabaseReference? ref = _database?.ref(
      Routes.userData(userId ?? ""),
    );

    var data = (await ref?.onValue.first)?.snapshot.value;
    var mapObject = data as Map<Object?, Object?>;
    var mapDynamic = Map<String, dynamic>.from(mapObject);
    var result  = UserDataViewModel.fromJson(mapDynamic);

    return result.items;
  }

  Future<void> setUserData({
    required List<KanbanViewModel> items,
    required String? userId,
  }) async {
    DatabaseReference? ref = _database?.ref(
      Routes.userData(userId ?? ""),
    );
    var model = UserDataViewModel(items: items);
    await ref?.set(model.toJson());
  }
}
