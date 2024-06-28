import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/categories/models/categories.model.dart';
import 'package:rst/modules/definitions/collectors/models/collectors.model.dart';
import 'package:rst/modules/definitions/economical_activities/models/economical_activities.model.dart';
import 'package:rst/modules/definitions/localities/models/localities.model.dart';
import 'package:rst/modules/definitions/personal_status/models/structure/structure.model.dart';

// structure will help to facilitate sort, filter, and data filelds use case

class CustomerStructure {
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

  static Field address = Field(
    front: 'Adresse',
    back: 'address',
    type: String,
    isNullable: false,
    isRelation: false,
  );

  static Field occupation = Field(
    front: 'Profession',
    back: 'occupation',
    type: String,
    isNullable: true,
    isRelation: false,
  );

  static Field nicNumber = Field(
    front: 'CNI/NPI',
    back: 'nicNumber',
    type: int,
    isNullable: true,
    isRelation: false,
  );

  static Field collector = Field(
    front: 'Collecteur',
    back: 'collector',
    type: String,
    isNullable: true,
    isRelation: true,
    fields: CollectorStructure.fields,
  );

  static Field locality = Field(
    front: 'Localité',
    back: 'locality',
    type: String,
    isNullable: true,
    isRelation: true,
    fields: LocalityStructure.fields,
  );

  static Field category = Field(
    front: 'Catégorie',
    back: 'category',
    type: String,
    isNullable: true,
    isRelation: true,
    fields: CategoryStructure.fields,
  );

  static Field economicalActivity = Field(
    front: 'Activité Économique',
    back: 'economicalActivity',
    type: String,
    isNullable: true,
    isRelation: true,
    fields: EconomicalActivityStructure.fields,
  );

  static Field personalStatus = Field(
    front: 'Statut Personnel',
    back: 'personalStatus',
    type: String,
    isNullable: true,
    isRelation: true,
    fields: PersonalStatusStructure.fields,
  );

  static Field profile = Field(
    front: 'Profil',
    back: 'profile',
    type: String,
    isNullable: true,
    isRelation: false,
  );

  static Field signature = Field(
    front: 'Signature',
    back: 'signature',
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
    firstnames,
    phoneNumber,
    address,
    profile,
    occupation,
    nicNumber,
    collector,
    locality,
    category,
    economicalActivity,
    personalStatus,
    createdAt,
    updatedAt,
  ];
}
