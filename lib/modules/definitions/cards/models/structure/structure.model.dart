import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';
import 'package:rst/modules/definitions/types/models/structure/structure.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class CardStructure {
  static Field id = Field(
    front: 'ID',
    back: 'id',
    type: int,
    isNullable: false,
    isRelation: false,
  );

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
    fields: TypeStructure.fields
        .where(
          (field) => field.back != 'id',
        )
        .toList(),
  );

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
    fields: CustomerStructure.fields.where(
          (field) => field.back != 'id',
        )
        .toList(),
  );

  static Field repaidAt = Field(
    front: 'Date de Remboursement',
    back: 'repaidAt',
    type: DateTime,
    isNullable: true,
    isRelation: false,
  );

  static Field satisfiedAt = Field(
    front: 'Date de Satisfaction',
    back: 'satisfiedAt',
    type: DateTime,
    isNullable: true,
    isRelation: false,
  );

  static Field transferredAt = Field(
    front: 'Date de Transfert',
    back: 'transferredAt',
    type: DateTime,
    isNullable: true,
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
    id,
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
