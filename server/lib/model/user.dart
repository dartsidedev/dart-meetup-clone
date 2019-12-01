import 'package:aqueduct/managed_auth.dart';

import '../dart_meetup_clone_server.dart';

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {}
