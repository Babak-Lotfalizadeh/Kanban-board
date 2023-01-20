import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:kanban_board/enums/routes.dart';
import 'package:kanban_board/view_model/kanban_view_model.dart';

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

    var data = await ref?.onValue.toList();
    return data?.map((element) => KanbanViewModel.fromJson(
        Map<String, dynamic>.from(element.snapshot.value as Map<Object?, Object?>),
      ),
    )
        .toList() ?? [];
  }

  // Future<void> sendMessage({
  //   required String? userId,
  //   required String message,
  //   required ContactViewModel? contactViewModel,
  // }) async {
  //   DatabaseReference? ref = _database?.ref(
  //     Routes.setChats(contactViewModel?.chatId ?? "1"),
  //   );
  //
  //   var model = ChatViewModel(
  //     id: const Uuid().v1(),
  //     sender: userId ?? "1",
  //     message: message,
  //     received: false,
  //     seen: false,
  //     chatId: contactViewModel?.chatId ?? "",
  //     receiver: contactViewModel?.contactId ?? "",
  //     dateTime: DateTime.now(),
  //   );
  //   await ref?.set(model.toJson());
  // }
}
