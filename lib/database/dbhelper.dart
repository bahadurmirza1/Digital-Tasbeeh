import 'package:sqflite/sqflite.dart';
import 'package:digital_tasbeeh/Model/tasbeeh.dart';

class DatabaseHelper {
  static Database? _database;
  DatabaseHelper._privateConstructor();

  static DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    // if(_database==null)
    //     _database=await initializeDatabase();
    _database ??= await initializeDatabase();

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String dbpath = await getDatabasesPath();
    dbpath = dbpath + "/mydb.db";
    var stddb = await openDatabase(dbpath, version: 1, onCreate: _createdb);
    return stddb;
  }

  void _createdb(Database db, int newversion) async {
    // creations of tables
    String query = '''create table tasbeeh
                    (
                      tid INTEGER PRIMARY KEY AUTOINCREMENT,
                      tname TEXT,
                      tcount INTEGER,
                      ttotal INTEGER
                       ) 
                    ''';
    db.execute(query);
    print('table created..');
    Tasbeeh t = new Tasbeeh();
    t.tcount = 0;
    t.tname = "اللّٰهُ أَكْبَر";
    t.ttotal = 0;
    int result = await db.insert('tasbeeh', t.toMap());
    print('inserted.... ');
  }

  Future<int> insertTasbeeh(Tasbeeh std) async {
    Database db = await instance.database;
    // String query='''
    //                insert into student values (
    //                 '${std.id}',
    //                 '${std.name}',
    //                 '${std.age}',
    //                 '${std.contact}';
    //                 )

    //                 ''';

    //                 db.rawInsert(query);
    int result = await db.insert('tasbeeh', std.toMap());
    print('inserted.... ');
    return result;
  }

  Future<List<Tasbeeh>> getAllData() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query('tasbeeh');

    List<Tasbeeh> slist = [];
    for (int i = 0; i < data.length; i++) {
      Map<String, dynamic> m = data[i];
      Tasbeeh s = Tasbeeh.fromMap(m);
      slist.add(s);
    }
    print('length ${slist.length}');
    return slist;
  }

  Future<int> updateCounter(Tasbeeh s) async {
    Database db = await instance.database;
    // String query='''
    //   update tasbeeh set
    //            tcount='${s.tcount}',
    //            where pid='${s.pid}'
    //             ''';
    //         int r =await db.rawUpdate(query);
    int r = await db
        .update('tasbeeh', s.toMap(), where: "tid=?", whereArgs: [s.tid]);

    print('rows effected $r');

    return r;
  }

  // Future<bool> ValidateUser(String uname, String pass) async {
  //   bool flag = false;
  //   Database db = await instance.database;
  //   List<Map<String, dynamic>> data = await db.query('user');

  //   List<User> slist = [];
  //   for (int i = 0; i < data.length; i++) {
  //     Map<String, dynamic> m = data[i];
  //     User s = User.fromMap(m);
  //     slist.add(s);
  //     if (slist[i].username == uname && slist[i].password == pass) {
  //       flag = true;
  //     }
  //   }
  //   //print('length ${slist.length}');
  //   return flag;
  // }

  Future<int> deleteTasbeeh(int id) async {
    Database db = await instance.database;
    // String query='''
    //              delete from student where id=$id
    //              ''';
    //            int r = await db.rawDelete(query);
    //            return r;
    int r = await db.delete('tasbeeh', where: "tid=?", whereArgs: [id]);
    // delte from student where id=1 and age is greater than 17
    //db.delete('student',where: "id=? and age > ?",whereArgs: [1,17]);
    return r;
  }
}
