import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration5 extends Migration {
  @override
  Future upgrade() async {
    database.addColumn(
      "_User",
      SchemaColumn(
        "description",
        ManagedPropertyType.string,
        isPrimaryKey: false,
        autoincrement: false,
        isIndexed: false,
        isNullable: true,
        isUnique: false,
      ),
    );
    database.addColumn(
      "_User",
      SchemaColumn(
        "twitter",
        ManagedPropertyType.string,
        isPrimaryKey: false,
        autoincrement: false,
        isIndexed: false,
        isNullable: true,
        isUnique: false,
      ),
    );
    database.addColumn(
      "_User",
      SchemaColumn(
        "linkedin",
        ManagedPropertyType.string,
        isPrimaryKey: false,
        autoincrement: false,
        isIndexed: false,
        isNullable: true,
        isUnique: false,
      ),
    );
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}
