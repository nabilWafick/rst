import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/definitions/collectors/models/collectors.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class CollectionStructure {
  static Field id = Field(
    front: 'ID',
    back: 'id',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field amount = Field(
    front: 'Montant',
    back: 'amount',
    type: double,
    isNullable: false,
    isRelation: false,
  );

  static Field rest = Field(
    front: 'Reste',
    back: 'rest',
    type: double,
    isNullable: false,
    isRelation: false,
  );

  static Field collectedAt = Field(
    front: 'Date',
    back: 'collectedAt',
    type: double,
    isNullable: false,
    isRelation: false,
  );

  static Field collector = Field(
    front: 'Collecteur',
    back: 'collector',
    type: String,
    isNullable: false,
    isRelation: true,
    fields: CollectorStructure.fields
        .where(
          (field) => field.back != 'id',
        )
        .toList(),
  );

  static Field agent = Field(
    front: 'Agent',
    back: 'agent',
    type: String,
    isNullable: true,
    isRelation: false,
    fields: AgentStructure.fields
        .where(
          (field) => field.back != 'id',
        )
        .toList(),
  );

  static Field createdAt = Field(
    front: 'Insertion',
    back: 'createdAt',
    type: DateTime,
    isNullable: false,
    isRelation: false,
  );

  static Field updatedAt = Field(
    front: 'Dernière Modification',
    back: 'updatedAt',
    type: DateTime,
    isNullable: false,
    isRelation: false,
  );

  static List<Field> fields = [
    id,
    amount,
    rest,
    collectedAt,
    collector,
    agent,
    createdAt,
    updatedAt,
  ];
}
