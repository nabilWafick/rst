import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class CardStructure {
  static Field label = Field(
    front: 'Libellé',
    back: 'label',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field type = Field(
      front: 'Type',
      back: 'type',
      type: String,
      isNullable: false,
      isRelation: true,
      fields: [
        Field(
          front: 'Libellé',
          back: 'label',
          type: String,
          isNullable: false,
          isRelation: false,
        ),
      ]);

  static Field typesNumber = Field(
    front: 'Nombre Type',
    back: 'typesNumber',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field customer = Field(
    front: 'Client',
    back: 'customer',
    type: String,
    isNullable: false,
    isRelation: true,
    fields: CustomerStructure.fields,
  );

  static Field repaidAt = Field(
    front: 'Date de Remboursement',
    back: 'repaidAt',
    type: DateTime,
    isNullable: false,
    isRelation: false,
  );

  static Field satisfiedAt = Field(
    front: 'Date de Satisfaction',
    back: 'satisfiedAt',
    type: DateTime,
    isNullable: false,
    isRelation: false,
  );

  static Field transferredAt = Field(
    front: 'Date de Transfert',
    back: 'transferredAt',
    type: DateTime,
    isNullable: false,
    isRelation: false,
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
    label,
    type,
    typesNumber,
    customer,
    repaidAt,
    satisfiedAt,
    transferredAt,
    createdAt,
    updatedAt,
  ];
}
