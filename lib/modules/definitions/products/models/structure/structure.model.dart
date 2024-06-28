import 'package:rst/common/models/common.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class ProductStructure {
  static Field id = Field(
    front: 'ID',
    back: 'id',
    type: int,
    isNullable: false,
    isRelation: false,
  );

  static Field name = Field(
    front: 'Nom',
    back: 'name',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field purchasePrice = Field(
    front: 'Prix d\'achat',
    back: 'purchasePrice',
    type: double,
    isNullable: false,
    isRelation: false,
  );

  static Field photo = Field(
    front: 'Photo',
    back: 'photo',
    type: String,
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
    name,
    purchasePrice,
    photo,
    createdAt,
    updatedAt,
  ];
}
