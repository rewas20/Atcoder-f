final String tableLeader = 'leader';

class LeaderFields {
  static final List<String> values = [
    id,name,gender,typeUser
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String gender = 'gender';
  static final String typeUser = 'typeUser';
}

class LeaderModel {
  final int? id;
  final String name;
  final String gender;
  final String typeUser;

  LeaderModel({
    this.id,
    required this.name,
    required this.gender,
    required this.typeUser
  });

  LeaderModel copy({
    int? id,
    String? name,
    String? gender,
    String? typeUser,
  }) =>
      LeaderModel(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        typeUser: typeUser ?? this.typeUser,
      );
  static LeaderModel fromJson(Map<String,Object?> json)=>LeaderModel(
    id: json[LeaderFields.id] as int,
    name: json[LeaderFields.name] as String,
    gender: json[LeaderFields.gender] as String,
    typeUser: json[LeaderFields.typeUser] as String,

  );
  Map<String,Object?> getMap(){
    return {
      LeaderFields.id: id,
      LeaderFields.name: name,
      LeaderFields.gender: gender,
      LeaderFields.typeUser: typeUser,
    };
  }
}