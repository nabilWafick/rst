import 'package:rst/common/models/common.model.dart';

class ProductStructure {
  static Field name = Field(
    front: 'Nom',
    back: 'name',
  );

  static Field purchasePrice = Field(
    front: 'Prix d\'achat',
    back: 'purchasePrice',
  );

  static Field photo = Field(
    front: 'Photo',
    back: 'photo',
  );

  static Field createdAt = Field(
    front: 'Insertion',
    back: 'createdAt',
  );

  static Field updatedAt = Field(
    front: 'Dernière Modification',
    back: 'updatedAt',
  );

  static List<Field> fields = [
    name,
    purchasePrice,
    photo,
    createdAt,
    updatedAt,
  ];
}
