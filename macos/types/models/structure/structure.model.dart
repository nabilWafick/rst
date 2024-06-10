import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class TypeStructure {
  static Field name = Field(
    front: 'Nom',
    back: 'name',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field stake = Field(
    front: 'Mise',
    back: 'stake',
    type: double,
    isNullable: false,
    isRelation: false,
  );

  static Field typeProducts = Field(
    front: 'Produits',
    back: 'typeProducts',
    type: String,
    isNullable: true,
    isRelation: true,
    fields: [
      Field(
        front: 'Au moins un',
        back: 'some',
        type: String,
        isNullable: false,
        isRelation: true,
        fields: [
          Field(
            front: 'Nombre',
            back: 'productNumber',
            type: int,
            isNullable: false,
            isRelation: false,
          ),
          Field(
            front: 'Produit',
            back: 'product',
            type: String,
            isNullable: false,
            isRelation: true,
            fields: ProductStructure.fields,
          ),
        ],
      ),
    ],
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
    name,
    stake,
    typeProducts,
    createdAt,
    updatedAt,
  ];
}
