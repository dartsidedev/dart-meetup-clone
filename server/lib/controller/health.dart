import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class HealthController extends Controller {
  @override
  FutureOr<RequestOrResponse> handle(Request request) {
    if (request.method == 'GET') {
      return Response.ok({});
    }
    return Response.badRequest();
  }
}
