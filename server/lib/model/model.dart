import '../dart_meetup_clone_server.dart';

class Model extends ManagedObject<_Model> implements _Model {
  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
  }
}

class _Model {
  @primaryKey
  int id;

  @Column(indexed: true)
  String name;

  DateTime createdAt;
}
