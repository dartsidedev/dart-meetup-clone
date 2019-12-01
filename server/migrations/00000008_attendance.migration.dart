import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration8 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(
      SchemaTable(
        "_Attendance",
        [
          SchemaColumn(
            "id",
            ManagedPropertyType.bigInteger,
            isPrimaryKey: true,
            autoincrement: true,
            isIndexed: false,
            isNullable: false,
            isUnique: false,
          ),
          SchemaColumn(
            "signedUpAt",
            ManagedPropertyType.datetime,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false,
          ),
        ],
      ),
    );
    database.addColumn(
      "_Attendance",
      SchemaColumn.relationship(
        "event",
        ManagedPropertyType.bigInteger,
        relatedTableName: "_Event",
        relatedColumnName: "id",
        rule: DeleteRule.nullify,
        isNullable: true,
        isUnique: false,
      ),
    );
    database.addColumn(
      "_Attendance",
      SchemaColumn.relationship(
        "user",
        ManagedPropertyType.bigInteger,
        relatedTableName: "_User",
        relatedColumnName: "id",
        rule: DeleteRule.nullify,
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
