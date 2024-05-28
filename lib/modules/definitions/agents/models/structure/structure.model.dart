import 'package:rst/common/models/common.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class AgentStructure {
  static Field name = Field(
    front: 'Nom',
    back: 'name',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field firstnames = Field(
    front: 'Prénoms',
    back: 'firstnames',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field phoneNumber = Field(
    front: 'Téléphone',
    back: 'phoneNumber',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field email = Field(
    front: 'Email',
    back: 'email',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field address = Field(
    front: 'Adresse',
    back: 'address',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field profile = Field(
    front: 'Profil',
    back: 'profile',
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
    name,
    firstnames,
    phoneNumber,
    email,
    address,
    profile,
    createdAt,
    updatedAt,
  ];
}
