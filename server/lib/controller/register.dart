import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

import '../model/user.dart';

class RegisterController extends ResourceController {
  RegisterController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    // Validate request parameters before we spend time hashing
    final missingFields = <String>[];
    final invalidFields = <String>[];

    if (user.username == null) {
      missingFields.add('user');
    } else if (user.username.length < 6) {
      invalidFields.add('user');
    }

    if (user.password == null) {
      missingFields.add('password');
    } else if (user.password.length < 6) {
      invalidFields.add('password');
    }

    if (missingFields.isNotEmpty) {
      return Response.badRequest(body: {
        'errors': [
          if (missingFields.isNotEmpty)
            'The following required fields are missing: ${missingFields.join(', ')}.',
          if (invalidFields.isNotEmpty)
            'The following fields are invalid: ${invalidFields.join(', ')}.',
        ],
        if (missingFields.isNotEmpty) 'missing_fields': missingFields,
        if (invalidFields.isNotEmpty) 'invalid_fields': invalidFields,
      });
    }

    user
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password, user.salt);

    return Response.ok(await Query(context, values: user).insert());
  }
}
