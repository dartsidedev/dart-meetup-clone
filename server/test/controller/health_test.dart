import '../harness/app.dart';

Future<void> main() async {
  final harness = Harness()..install();

  tearDown(() async {
    await harness.resetData();
  });

  test('POST /health', () async {
    final response = await harness.agent.post('/health');
    expect(response.statusCode, 400);
  });

  test('GET /health', () async {
    final response = await harness.agent.get('health');
    expect(response.statusCode, 200);
  });
}
