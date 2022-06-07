final String tableAttendance = 'attendance';

class AttendanceFields {
  static final List<String> values = [
    id,name,gender,typeUser,date,time
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String gender = 'gender';
  static final String typeUser = 'typeUser';
  static final String date = 'date';
  static final String time = 'time';
}

class AttendanceModel {
  final int? id;
  final String name;
  final String gender;
  final String typeUser;
  final String date;
  final String time;

  AttendanceModel({
    this.id,
    required this.name,
    required this.gender,
    required this.typeUser,
    required this.date,
    required this.time
  });

  AttendanceModel copy({
    int? id,
    String? name,
    String? gender,
    String? typeUser,
    String? date,
    String? time,
  }) =>
      AttendanceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        typeUser: typeUser ?? this.typeUser,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  static AttendanceModel fromJson(Map<String,Object?> json)=>AttendanceModel(
    id: json[AttendanceFields.id] as int,
    name: json[AttendanceFields.name] as String,
    gender: json[AttendanceFields.gender] as String,
    typeUser: json[AttendanceFields.typeUser] as String,
    date: json[AttendanceFields.date] as String,
    time: json[AttendanceFields.time] as String,
  );
  static String fromJsonToString(Map<String,Object?> json)=>json[AttendanceFields.date] as String;
  Map<String,Object?> getMap(){
    return {
      AttendanceFields.id:id,
      AttendanceFields.name:name,
      AttendanceFields.gender:gender,
      AttendanceFields.typeUser:typeUser,
      AttendanceFields.date:date,
      AttendanceFields.time:time,
    };
  }



}