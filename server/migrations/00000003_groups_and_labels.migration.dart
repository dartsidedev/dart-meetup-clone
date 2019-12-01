import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration3 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(
      SchemaTable(
        "_Group",
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
            "name",
            ManagedPropertyType.string,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false,
          ),
          SchemaColumn(
            "description",
            ManagedPropertyType.string,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false,
          )
        ],
      ),
    );
    database.createTable(
      SchemaTable(
        "_Label",
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
            "name",
            ManagedPropertyType.string,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false,
          )
        ],
      ),
    );
    database.createTable(
      SchemaTable(
        "_GroupLabel",
        [
          SchemaColumn(
            "id",
            ManagedPropertyType.bigInteger,
            isPrimaryKey: true,
            autoincrement: true,
            isIndexed: false,
            isNullable: false,
            isUnique: false,
          )
        ],
      ),
    );
    database.addColumn(
      "_GroupLabel",
      SchemaColumn.relationship(
        "group",
        ManagedPropertyType.bigInteger,
        relatedTableName: "_Group",
        relatedColumnName: "id",
        rule: DeleteRule.nullify,
        isNullable: true,
        isUnique: false,
      ),
    );
    database.addColumn(
      "_GroupLabel",
      SchemaColumn.relationship(
        "label",
        ManagedPropertyType.bigInteger,
        relatedTableName: "_Label",
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
