import './harness/app.dart';

Future<void> main() async {
  final harness = Harness()..install();

  tearDown(() async {
    await harness.resetData();
  });

  group('POST /register', () {
    test('valid data', () async {
      final response = await harness.agent.post(
        '/register',
        body: {
          'username': 'vargavince91',
          'password': '123456',
        },
      );
      expect(
        response,
        hasResponse(
          200,
          body: {
            'username': 'vargavince91',
            'id': isInteger,
          },
        ),
      );
    });
  });
}
