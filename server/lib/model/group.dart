import 'package:dart_meetup_clone_server/dart_meetup_clone_server.dart';

class Group extends ManagedObject<_Group> implements _Group {}

class _Group {
  @primaryKey
  int id;

  String name;

  String description;

  ManagedSet<GroupLabel> groupLabels;

  ManagedSet<Event> events;
}

class GroupLabel extends ManagedObject<_GroupLabel> implements _GroupLabel {}

class _GroupLabel {
  @primaryKey
  int id;

  @Relate(#groupLabels)
  Group group;

  @Relate(#groupLabels)
  Label label;
}

class Label extends ManagedObject<_Label> implements _Label {}

class _Label {
  @primaryKey
  int id;

  String name;

  ManagedSet<GroupLabel> groupLabels;
}

class Event extends ManagedObject<_Event> implements _Event {}

class _Event {
  @primaryKey
  int id;

  String name;

  String description;

  @Relate(#events)
  Group group;
}
