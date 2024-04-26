import 'package:axiocash/Model/AxModel.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  late Database dbase;

  static final DbHelper dbHelper = DbHelper._();

  String axTable = "axTable";

  String id = "id";
  String name = "name";
  String phno = "phno";
  String item = "item";
  String amount = "amount";
  String date = "date";
  String time = "time";
  String type = "type";
  String pdate = "pdate";

  initDb() async {
    String databasePath = await getDatabasesPath();
    String DbName = "h.db";
    String path = join(databasePath, DbName);

    dbase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db
          .execute(
              "CREATE TABLE $axTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $phno TEXT, $item TEXT, $amount TEXT, $date TEXT, $time TEXT, $type TEXT, $pdate TEXT)")
          .then((value) {
        Logger().d("$axTable are Created Successfully");
      }).catchError((error) {
        Logger().e(error.toString());
      });
    });
  }

  insertTransaction(AxioModal axioModal) async {
    await initDb();
    String query =
        " INSERT INTO $axTable( $name, $phno, $item, $amount, $date, $time, $type, $pdate) VALUES(?,?,?,?,?,?,?,?)";
    List args = [
      axioModal.name,
      axioModal.phno,
      axioModal.item,
      axioModal.amount,
      axioModal.date,
      axioModal.time,
      axioModal.type,
      axioModal.pdate
    ];
    return await dbase.rawInsert(query, args).then((value) {
      Logger().d("AxioModal inserted successfully. $value");
    }).catchError((error) {
      Logger().e(error.toString());
    });
  }

  Future<List<AxioModal>> getTransaction() async {
    await initDb();
    String query = "SELECT * FROM $axTable";
    List<Map> list = await dbase.rawQuery(query);
    Logger().d(list);
    return list.map((e) => AxioModal.fromMap(e)).toList();
  }

  Future<int> deleteTransaction(int aid) async {
    await initDb();
    String query = "DELETE FROM $axTable WHERE $id = ?";
    return await dbase.rawDelete(query, [aid]);
  }

  Future<int> updateTransaction(
      String aname, String aphno, String aitem, String aamount, int aid) async {
    await initDb();
    String query =
        "UPDATE $axTable SET $name = ?,$phno = ?, $item = ?, $amount = ? WHERE $id = ?";
    List args = [aname, aphno, aitem, aamount, aid];
    return await dbase.rawUpdate(query, args);
  }

  Future<int> collectTransaction(int id) async {
    await initDb();
    await dbase
        .rawUpdate("UPDATE $axTable SET type = 'INCOME' WHERE id = ?", [id]);
    return 1;
  }
}
