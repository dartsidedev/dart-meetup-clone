import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(
      SchemaTable(
        "_Model",
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
            isIndexed: true,
            isNullable: false,
            isUnique: false,
          ),
          SchemaColumn(
            "createdAt",
            ManagedPropertyType.datetime,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false,
            defaultValue: 'CURRENT_TIMESTAMP',
          )
        ],
      ),
    );
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final names = ['Logitech', 'Huawei', 'Apple'];
    final exec = database.store.execute;
    for (final name in names) {
      await exec(
        'INSERT INTO _Model (name) VALUES (@name)',
        substitutionValues: {'name': name},
      );
    }
  }
}
