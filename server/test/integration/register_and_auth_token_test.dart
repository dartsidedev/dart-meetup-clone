import './harness/app.dart';

Future<void> main() async {
  final harness = Harness()..install();

  tearDown(() async {
    await harness.resetData();
  });

  test('protected endpoint', () async {
    final agent = await harness.registerUser('vargavince91', 'password');
    final protectedPath = await agent.get('/protected');
    expect(protectedPath.statusCode, 200);
  });

  test('protected manual', () async {
    const username = 'vargavince91';
    const password = 'password';
    final registerResponse = await harness.agent.post(
      '/register',
      body: {
        'username': username,
        'password': password,
      },
    );
    expect(registerResponse.statusCode, 200);
    final authTokenResponse = await harness.agent.post(
      '/auth/token',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader:
            'Basic ZGFydHNpZGVkZXYuZGFydF9tZWV0dXBfY2xvbmU6',
      },
      body: 'username=$username&password=$password&grant_type=password',
    );
    expect(authTokenResponse.statusCode, 200);
    final authTokenResponseBody =
        authTokenResponse.body.as<Map<String, dynamic>>();
    expect(authTokenResponseBody['access_token'], isString);
    expect(authTokenResponseBody['token_type'], 'bearer');
    expect(authTokenResponseBody['expires_in'], isInteger);
  }, skip: 'should return 200 but returns 415');
}
