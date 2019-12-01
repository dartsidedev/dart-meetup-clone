import 'package:dart_meetup_clone_server/dart_meetup_clone_server.dart';
import 'package:aqueduct_test/aqueduct_test.dart';
import 'package:dart_meetup_clone_server/model/user.dart';

export 'package:dart_meetup_clone_server/dart_meetup_clone_server.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

/// A testing harness for dart_meetup_clone_server.
///
/// A harness for testing an aqueduct application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<DartMeetupCloneServerChannel>
    with
        TestHarnessORMMixin,
        TestHarnessAuthMixin<DartMeetupCloneServerChannel> {
  @override
  ManagedContext get context => channel.context;

  @override
  AuthServer get authServer => channel.authServer;

  Agent publicAgent;

  @override
  Future onSetUp() async {
    await resetData();
    publicAgent = await addClient('dartsidedev.dart_meetup_clone');
  }

  Future<Agent> registerUser(String username, String password,
      {Agent withClient}) async {
    withClient ??= publicAgent;
    final request = withClient.request('/register')
      ..body = {'username': username, 'password': password};
    await request.post();
    return loginUser(withClient, username, password);
  }

  @override
  Future onTearDown() async {}

  @override
  Future seed() async {
    // restore any static data. called by resetData.
  }
}
