import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  static final Repository _instance = Repository._internal();

  factory Repository() => _instance;

  // singleton
  Repository._internal();

  Database _db;

  Future<List<Memo>> memo() async {
    await Future.delayed(Duration(seconds: 3));

    return [
      Memo(
        borrowOrLend: 'borrow',
        stuff: 'stuff',
        date: DateTime.now(),
        user: 'admin',
      ),
      Memo(
        borrowOrLend: 'borrow',
        stuff: '2',
        date: DateTime.now(),
        user: 'taro',
      ),
    ];
  }

  Future<void> init() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'memo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE memos("
          " id INTEGER PRIMARY KEY AUTOINCREMENT,"
          " borrowOrLend TEXT,"
          " stuff TEXT,"
          " date TEXT,"
          " user TEXT"
          ")",
        );
      },
      version: 1,
    );
  }

  Future<void> saveMemo(Memo memo) async {
    print(memo);
    _db.insert('memos', memo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Memo>> fetchMemoList() async {
    final List<Map<String, dynamic>> maps = await _db.query('memos');

    return List.generate(maps.length, (i) {
      return Memo(
        borrowOrLend: maps[i]['borrowOrLend'],
        stuff: maps[i]['stuff'],
        date: DateTime.parse(maps[i]['date']),
        user: maps[i]['user'],
      );
    });
  }
}

class Memo {
  final String borrowOrLend;
  final String stuff;
  final DateTime date;
  final String user;

  const Memo({this.borrowOrLend, this.stuff, this.date, this.user});

  @override
  String toString() {
    return 'Memo{borrowOrLend: $borrowOrLend, stuff: $stuff, date: $date, user: $user}';
  }

  Map<String, dynamic> toMap() {
    return {
      'borrowOrLend': borrowOrLend,
      'stuff': stuff,
      'date': date.toIso8601String(),
      'user': user,
    };
  }
}
