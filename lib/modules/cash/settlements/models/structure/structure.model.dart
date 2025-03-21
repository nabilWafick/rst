import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/cash/collections/models/structure/structure.model.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/definitions/cards/models/structure/structure.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class SettlementStructure {
  static Field id = Field(
    front: 'ID',
    back: 'id',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field number = Field(
    front: 'Nombre',
    back: 'number',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field isValidated = Field(
    front: 'Est Validé',
    back: 'isValidated',
    type: bool,
    isNullable: false,
    isRelation: false,
  );

  static Field card = Field(
    front: 'Carte',
    back: 'card',
    type: String,
    isNullable: false,
    isRelation: true,
    fields: CardStructure.fields
        .where(
          (field) => field.back != 'id',
        )
        .toList(),
  );

  static Field collection = Field(
    front: 'Collecte',
    back: 'collection',
    type: String,
    isNullable: true,
    isRelation: true,
    fields: CollectionStructure.fields
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
    number,
    isValidated,
    card,
    collection,
    agent,
    createdAt,
    updatedAt,
  ];
}
