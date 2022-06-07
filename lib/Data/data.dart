import 'package:attendance/Models/category.dart';
import 'package:attendance/Models/leader.dart';
import 'package:attendance/Models/person.dart';
import 'package:attendance/Screens/attendance_screen.dart';
import 'package:attendance/Screens/boys_screen.dart';
import 'package:attendance/Screens/girls_screen.dart';
import 'package:attendance/Screens/leaders_screen.dart';
import 'package:attendance/Screens/names_screen.dart';
import 'package:attendance/Screens/scan_screen.dart';

var CATEGORY_HOME = [
  CategoryModel(name: "Scan QR", routeName: ScanScreen.routeName),
  CategoryModel(name: "Names", routeName: NamesScreen.routeName),
  CategoryModel(name: "Attendance", routeName: AttendanceScreen.routeName),
];

var CATEGORY_NAMES = [
  CategoryModel(name: "Boys", routeName: BoysScreen.routeName),
  CategoryModel(name: "Girls", routeName: GirlsScreen.routeName),
  CategoryModel(name: "Leaders", routeName: LeadersScreen.routeName),
];


var DATA_PERSONS = [
  PersonModel(name: "Gerges Sameh", gender: "male", typeUser: 'فرد'),
  PersonModel(name: "Antonious George", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Tony George", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "philobateer Nagib", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "philobateer Atef", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "philobateer George Ebid", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "philobateer George Farid", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Michael Daniel", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "philobateer Keemy", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "philobateer sherif", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "poula samy", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "shenouda mina", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Mina Edward", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Mina Magdy", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "pemen Farid", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "philobateer Emad", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Philobateer Abanoub", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Mina Ashraf", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Giovanny Rafik", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Ghaly", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Botros Mounir", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Botros Adel", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Naiem", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Atef", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Hosny", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Mina Meshel", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "karas Hany", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "karas Ayman", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Basillious Botros", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Remon", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kirollos Maged", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Fady Matar", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Mina Gad", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "David Sameeh", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "David mikhael", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Gastin Melad", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Gohn Ayman", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Mina George", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "kevin michael", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Bavly Hany", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Mario melad", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "poula Benyamin", gender: "male",typeUser: 'فرد'),
  PersonModel(name: "Maria Hany", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Clarisse Spiro", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Juneer Medhat kamal", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Sara Mina", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Monika Wael", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Mariem Adel", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Youstina Emad", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Jasmen Ekramy", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Marline Adel", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Sandy Magdy", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Julia Ashraf", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Juneer Medhat Melad", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Youstina Aziz", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Mary Gerges", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Manritt Tamer", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Jumana Naser", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Justina Naser", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Sausanna Daniel", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Maria Maged", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Juneer Ragy", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Juneer Essam", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "July usama", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Elaria Isaac", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Juneer Raafat", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Maria Sameh", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Moren Mourise", gender: "female",typeUser: 'فرد'),
  PersonModel(name: "Maronia Gerges", gender: "female",typeUser: 'فرد'),
];

var DATA_LEADER = [
  LeaderModel( name: "C.Mina Lwez",gender: "male",typeUser: 'قائد'),
  LeaderModel( name: "C.Youssef Maher",gender: "male",typeUser: 'قائد'),
  LeaderModel(name: "C.Roshdy George",gender: "male",typeUser: 'قائد'),
  LeaderModel(name: "C.philobateer Gerges",gender: "male",typeUser: 'قائد'),
  LeaderModel(name: "C.Steven Sameeh",gender: "male",typeUser: 'قائد'),
  LeaderModel(name: "C.Michael Adel",gender: "male",typeUser: 'قائد'),
  LeaderModel(name: "Sh.Merna Fayez",gender: "female",typeUser: 'قائد'),
  LeaderModel(name: "Sh.Merna Magdy",gender: "female",typeUser: 'قائد'),
  LeaderModel(name: "Sh.Sara Gad",gender: "female",typeUser: 'قائد'),
  LeaderModel(name: "Sh.Lourina George",gender: "female",typeUser: 'قائد'),
];


