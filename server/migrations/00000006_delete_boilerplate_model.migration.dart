import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration6 extends Migration {
  @override
  Future upgrade() async {
    database.deleteTable("_Model");
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}
