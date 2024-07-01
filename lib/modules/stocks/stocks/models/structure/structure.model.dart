import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/definitions/cards/models/structure/structure.model.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class StockStructure {
  static Field id = Field(
    front: 'ID',
    back: 'id',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field product = Field(
    front: 'Produit',
    back: 'product',
    type: String,
    isNullable: false,
    isRelation: true,
    fields: ProductStructure.fields
        .where(
          (field) => field.back != 'id',
        )
        .toList(),
  );

  static Field initialQuantity = Field(
    front: 'Quantité Initiale',
    back: 'initialQuantity',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field stockQuantity = Field(
    front: 'Quantité Stock',
    back: 'stockQuantity',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field inputQuantity = Field(
    front: 'Quantité Entrée',
    back: 'inputQuantity',
    type: int,
    isNullable: true,
    isRelation: false,
  );

  static Field outputQuantity = Field(
    front: 'Quantité Sortie',
    back: 'outputQuantity',
    type: int,
    isNullable: true,
    isRelation: false,
  );

  static Field movementType = Field(
    front: 'Type Mouvement',
    back: 'movementType',
    type: String,
    isNullable: true,
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
    product,
    initialQuantity,
    stockQuantity,
    inputQuantity,
    outputQuantity,
    movementType,
    card,
    agent,
    createdAt,
    updatedAt,
  ];
}
