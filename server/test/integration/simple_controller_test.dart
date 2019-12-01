import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  tearDown(() async {
    await harness.resetData();
  });

  test('POST /model', () async {
    final response = await harness.agent.post(
      '/model',
      body: {'name': 'Bub'},
    );
    expect(
      response,
      hasResponse(
        200,
        body: {
          'id': isNotNull,
          'name': 'Bub',
          'createdAt': isTimestamp,
        },
      ),
    );
  });

  test('GET /model/:id returns previously created object', () async {
    final postResponse = await harness.agent.post(
      '/model',
      body: {'name': 'Bob'},
    );
    final createdObject = postResponse.body.as<Map<String, dynamic>>();
    final getResponse =
        await harness.agent.get('/model/${createdObject['id']}');
    final expectedBody = {
      'id': createdObject['id'],
      'name': createdObject['name'],
      'createdAt': createdObject['createdAt'],
    };
    expect(
      getResponse,
      hasResponse(
        200,
        body: expectedBody,
      ),
    );
  });
}
