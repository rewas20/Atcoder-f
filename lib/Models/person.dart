final String tablePerson = 'person';

class PersonFields {
  static final List<String> values = [
    id,name,gender,typeUser
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String gender = 'gender';
  static final String typeUser = 'typeUser';
}

class PersonModel {
  final int? id;
  final String name;
  final String gender;
  final String typeUser;

  PersonModel({
    this.id,
    required this.name,
    required this.gender,
    required this.typeUser
  });

  PersonModel copy({
    int? id,
    String? name,
    String? gender,
    String? typeUser,
  }) =>
      PersonModel(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        typeUser: typeUser ?? this.typeUser,
      );
  static PersonModel fromJson(Map<String,Object?> json)=>PersonModel(
    id: json[PersonFields.id] as int,
    name: json[PersonFields.name] as String,
    gender: json[PersonFields.gender] as String,
    typeUser: json[PersonFields.typeUser] as String,

  );
  Map<String, Object?> getMap() {
    return {
      PersonFields.id: id,
      PersonFields.name: name,
      PersonFields.gender: gender,
      PersonFields.typeUser: typeUser,
    };
  }
}