import 'package:attendance/Data/data.dart';
import 'package:attendance/Models/attendance.dart';
import 'package:attendance/Models/leader.dart';
import 'package:attendance/Models/person.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseProvider{

  static final DatabaseProvider instance = DatabaseProvider._init();

  static Database? _database;
  DatabaseProvider._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('attendance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filePath);
    //Fluttertoast.showToast(msg: path,toastLength: Toast.LENGTH_LONG);

    return await openDatabase(path,version: 1,onCreate: _createDB);
  }
  //Create DB for first run
  Future _createDB(Database db, int version) async{
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute(''' 
      CREATE TABLE $tableLeader (
        ${LeaderFields.id} $idType,
        ${LeaderFields.name} $textType,
        ${LeaderFields.gender} $textType, 
        ${LeaderFields.typeUser} $textType)  
    ''');
    await db.execute('''
      CREATE TABLE $tablePerson (
        ${PersonFields.id} $idType,
        ${PersonFields.name} $textType,
        ${PersonFields.gender} $textType,
        ${PersonFields.typeUser} $textType)
    ''');
    await db.execute('''
      CREATE TABLE $tableAttendance (
        ${AttendanceFields.id} $idType,
        ${AttendanceFields.name} $textType,
        ${AttendanceFields.gender} $textType,
        ${AttendanceFields.typeUser} $textType,
        ${AttendanceFields.date} $textType,
        ${AttendanceFields.time} $textType)
    ''');

    DATA_PERSONS.forEach((element) async {
      await db.insert(tablePerson,element.getMap());
    });
    DATA_LEADER.forEach((element) async {
      await db.insert(tableLeader,element.getMap());
    });
  }
  //=========================== Queries On DataBase ==========================
  //==================== table attendance ===========================
  //Create Attend for user
  Future<AttendanceModel> createAttend(AttendanceModel attendanceModel)async{
    final db = await instance.database;

    // final json = attendanceModel.getMap();
    // final columns = '${AttendanceFields.name}, ${AttendanceFields.gender} ,${AttendanceFields.typeUser} ,${AttendanceFields.date} ,${AttendanceFields.time}';
    // final values = '${attendanceModel.name}, ${attendanceModel.gender} ,${attendanceModel.typeUser} ,${attendanceModel.date} ,${attendanceModel.time}';
    //
    // final id = await db.rawInsert('INSERT INTO table_name($columns) VALUES ($values)');

    final id = await db.insert(tableAttendance, attendanceModel.getMap());
    return attendanceModel.copy(id: id);
  }
  //===========
  //Read one Attend for user by id
  Future<AttendanceModel> readAttendById(int id)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return AttendanceModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "ID $id not found");
      throw Exception('ID $id not found');
    }
  }
  //===========
  //Read one Attend for user time attend
  Future<List<AttendanceModel>> readAllAttendTime(String date)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.date} = ?',
      whereArgs: [date],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){

      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "Date $date not found");
      throw Exception('Date $date not found');
    }
  }
  //===========
  //Read one Attend for user by time attend
  Future<List<String>> readAllAttendByDate()async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.date} ASC';
    final groupBy = AttendanceFields.date;
    final maps = await db.query(tableAttendance,
    groupBy: groupBy,
    orderBy: orderBy);
    if(maps.isNotEmpty){
      return maps.map((json) => AttendanceModel.fromJsonToString(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "Date not found");
      throw Exception('Date not found');
    }
  }
  //===========
  //Read all Attend for users
  Future<List<AttendanceModel>> readAllAttend()async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "No Data");
      throw Exception('NO DATA');
    }
  }
  //===========
  //Edit on user attend By model
  Future<int> updateAttend(AttendanceModel attendanceModel)async{
    final db = await instance.database;
    return db.update(tableAttendance,
          attendanceModel.getMap(),
          where: '${AttendanceFields.id} = ?',
          whereArgs: [attendanceModel.id],
    );
  }
  //===========
  //Delete on table attend By Id
   Future<int> deleteAttend(int id)async{
      final db = await instance.database;
      return db.delete(tableAttendance,
            where: '${AttendanceFields.id} = ?',
            whereArgs: [id],
      );
    }
    //===========
    //Delete on table attend By Date
     Future deleteAttendByDate(String date)async{
        final db = await instance.database;
        return db.delete(tableAttendance,
              where: '${AttendanceFields.date} = ?',
              whereArgs: [date],
        );
      }
  //===========
  //Check attend By Id
  Future<bool> checkAttend(String name,String date)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.date} = ? AND ${AttendanceFields.name} = ?',
      whereArgs: [date,name],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  //==================== end table attendance ===========================

  //==================== table person ===============================
  //Create Person for user
    Future<PersonModel> createPerson(PersonModel personModel)async{
      final db = await instance.database;

      final id = await db.insert(tablePerson, personModel.getMap());
      return personModel.copy(id: id);
    }
    //===========
    //Read one Person for user by id
    Future<PersonModel> readPersonById(int id)async{
      final db = await instance.database;
      final maps = await db.query(
        tablePerson,
        columns: PersonFields.values,
        where: '${PersonFields.id} = ?',
        whereArgs: [id],
      );
      if(maps.isNotEmpty){
        return PersonModel.fromJson(maps.first);
      }else{
        Fluttertoast.showToast(msg: "ID $id not found");
        throw Exception('ID $id not found');
      }
    }
    //===========
    //Read one Person for user by Name
    Future<PersonModel> readPersonByName(String name)async{
      final db = await instance.database;
      final orderBy = '${PersonFields.gender} ASC';
      final maps = await db.query(
        tablePerson,
        columns: PersonFields.values,
        where: '${PersonFields.name} = ?',
        whereArgs: [name],
        orderBy: orderBy,
      );
      if(maps.isNotEmpty){
        return PersonModel.fromJson(maps.first);
      }else{
        Fluttertoast.showToast(msg: "name $name not found");
        throw Exception('name $name not found');
      }
    }
    //===========
    //Read one Person for user by gender
    Future<List<PersonModel>> readPersonByGender(String gender)async{
      final db = await instance.database;
      final orderBy = '${PersonFields.gender} ASC';
      final maps = await db.query(
        tablePerson,
        columns: PersonFields.values,
        where: '${PersonFields.gender} = ?',
        whereArgs: [gender],
        orderBy: orderBy,
      );
      if(maps.isNotEmpty){
        return maps.map((json) => PersonModel.fromJson(json)).toList();
      }else{
        Fluttertoast.showToast(msg: "gender $gender not found");
        throw Exception('gender $gender not found');
      }
    }
    //===========
    //Read all Persons for users
    Future<List<PersonModel>> readAllPersons()async{
      final db = await instance.database;
      final maps = await db.query(
        tablePerson
      );
      if(maps.isNotEmpty){
        return maps.map((json) => PersonModel.fromJson(json)).toList();
      }else{
        Fluttertoast.showToast(msg: "No Data");
        throw Exception('NO DATA');
      }
    }
    //===========
    //Edit on user Person By model
    Future<int> updatePerson(PersonModel personModel)async{
      final db = await instance.database;
      return db.update(tablePerson,
        personModel.getMap(),
        where: '${PersonFields.id} = ?',
        whereArgs: [personModel.id],
      );
    }
    //===========
    //Delete on table person By Id
    Future<int> deletePerson(int id)async{
      final db = await instance.database;
      return db.delete(tablePerson,
        where: '${PersonFields.id} = ?',
        whereArgs: [id],
      );
    }
    //===========
    //Check exit By Id
    Future<bool> checkPerson(String name)async{
      final db = await instance.database;
      final maps = await db.query(
        tablePerson,
        columns: PersonFields.values,
        where: '${PersonFields.name} = ?',
        whereArgs: [name],
      );
      if(maps.isNotEmpty){
        return true;
      }else{
        return false;
      }
    }
  //==================== end table person ===========================

  //==================== table leader ===============================
  //Create Leader for user
    Future<LeaderModel> createLeader(LeaderModel leaderModel)async{
      final db = await instance.database;

      final id = await db.insert(tableLeader, leaderModel.getMap());
      return leaderModel.copy(id: id);
    }
    //===========
    //Read one Leader for user by id
    Future<LeaderModel> readLeaderById(int id)async{
      final db = await instance.database;
      final maps = await db.query(
        tableLeader,
        columns: LeaderFields.values,
        where: '${LeaderFields.id} = ?',
        whereArgs: [id],
      );
      if(maps.isNotEmpty){
        return LeaderModel.fromJson(maps.first);
      }else{
        Fluttertoast.showToast(msg: "ID $id not found");
        throw Exception('ID $id not found');
      }
    }
    //===========
    //Read one Leader for user by Name
    Future<LeaderModel> readLeadersByName(String name)async{
      final db = await instance.database;
      final orderBy = '${LeaderFields.gender} ASC';
      final maps = await db.query(
        tableLeader,
        columns: LeaderFields.values,
        where: '${LeaderFields.name} = ?',
        whereArgs: [name],
        orderBy: orderBy,
      );
      if(maps.isNotEmpty){
        return LeaderModel.fromJson(maps.first);
      }else{
        Fluttertoast.showToast(msg: "name $name not found");
        throw Exception('name $name not found');
      }
    }
    //===========
    //Read all Leader for users
    Future<List<LeaderModel>> readAllLeaders()async{
      final db = await instance.database;
      final maps = await db.query(
          tableLeader
      );
      if(maps.isNotEmpty){
        return maps.map((json) => LeaderModel.fromJson(json)).toList();
      }else{
        Fluttertoast.showToast(msg: "No Data");
        throw Exception('NO DATA');
      }
    }
    //===========
    //Edit on user Leader By model
    Future<int> updateLeader(LeaderModel leaderModel)async{
      final db = await instance.database;
      return db.update(tableLeader,
        leaderModel.getMap(),
        where: '${PersonFields.id} = ?',
        whereArgs: [leaderModel.id],
      );
    }
    //===========
    //Delete on table leader By Id
    Future<int> deleteLeader(int id)async{
      final db = await instance.database;
      return db.delete(tableLeader,
        where: '${LeaderFields.id} = ?',
        whereArgs: [id],
      );
    }
    //===========
    //Check exit By Id
    Future<bool> checkLeader(String name)async{
      final db = await instance.database;
      final maps = await db.query(
        tableLeader,
        columns: LeaderFields.values,
        where: '${LeaderFields.name} = ?',
        whereArgs: [name],
      );
      if(maps.isNotEmpty){
        return true;
      }else{
        return false;
      }
    }
  //==================== end table leader ===========================

  //============================ End Queries On DataBase ==========================

  //=========== Close File db ==============
  Future close() async{
    final db = await instance.database;
    db.close();
  }
}