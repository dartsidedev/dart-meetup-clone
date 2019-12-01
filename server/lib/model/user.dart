import 'package:aqueduct/managed_auth.dart';

import '../dart_meetup_clone_server.dart';

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {
  @Column(nullable: true)
  String description;

  @Column(nullable: true)
  String twitter;

  @Column(nullable: true)
  String linkedin;
}
