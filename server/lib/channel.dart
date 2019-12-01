import 'package:aqueduct/managed_auth.dart';
import 'package:dart_meetup_clone_server/controller/health.dart';

import 'controller/register.dart';
import 'dart_meetup_clone_server.dart';
import 'model/model.dart';
import 'model/user.dart';

class DartMeetupCloneServerChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final configFilePath = options.configurationFilePath;
    final config = DartMeetupCloneServerConfiguration(configFilePath);
    context = contextWithConnectionInfo(config.database);
    authServer = AuthServer(ManagedAuthDelegate<User>(context));
  }

  @override
  Controller get entryPoint {
    return Router()
      ..route('/register').link(() => RegisterController(context, authServer))
      ..route('/auth/token').link(() => AuthController(authServer))
      ..route('/health').link(() => HealthController())
      ..route('/protected')
          .link(() => Authorizer.bearer(authServer))
          .linkFunction((request) => Response.ok({}))
      ..route('/model/[:id]')
          .link(() => ManagedObjectController<Model>(context));
  }

  ManagedContext contextWithConnectionInfo(
    DatabaseConfiguration connectionInfo,
  ) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    logger.info(
      'Username: ${connectionInfo.username}. '
      'Database: ${connectionInfo.databaseName}',
    );
    final persistentStore = PostgreSQLPersistentStore(
      connectionInfo.username,
      connectionInfo.password,
      connectionInfo.host,
      connectionInfo.port,
      connectionInfo.databaseName,
    );

    return ManagedContext(dataModel, persistentStore);
  }
}

/// An instance of this class reads values from a configuration
/// file specific to this application.
///
/// Configuration files must have key-value for the properties in this class.
/// For more documentation on configuration files, see https://aqueduct.io/docs/configure/ and
/// https://pub.dartlang.org/packages/safe_config.
class DartMeetupCloneServerConfiguration extends Configuration {
  DartMeetupCloneServerConfiguration(String fileName)
      : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}
