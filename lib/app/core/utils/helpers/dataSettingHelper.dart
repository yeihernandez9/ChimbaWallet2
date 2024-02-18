import 'package:chimba_wallet/app/data/model/setting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataSettingHelper {
  static Database? _walletDb;
  static DataSettingHelper? _dataSettingHelper;

  static final databaseName = "chimbaWallet.db";
  static final _databaseVersion = 1;
  static final table = 'setting';
  static final columnId = 'id';
  static final columnSetting = 'name';
  static final columnValue = 'value_status';
  static final columnDescription = 'description';

  DataSettingHelper._createInstance();

  static final DataSettingHelper db = DataSettingHelper._createInstance();

  factory DataSettingHelper() {
    _dataSettingHelper ??= DataSettingHelper._createInstance();
    return _dataSettingHelper!;
  }

  Future<Database> get database async {
    _walletDb ??= await initializeDatabase();
    return _walletDb!;
  }

  initializeDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnSetting TEXT, $columnValue TEXT, $columnDescription TEXT)");
  }

  Future<List<Map<String, Object?>>> getSettingMapList() async {
    Database db = await database;
    var result = await db.query(table, orderBy: "$columnId ASC");
    return result;
  }

  Future<int> insertSetting(Setting setting) async {
    Database db = await this.database;
    var result = await db.insert(table, setting.toMap());
    return result;
  }

  Future<int> updateSetting(Setting setting) async {
    print("MAP: ${setting.toMap()}");
    var db = await this.database;
    var result = await db.update(table, setting.toMap(),
        where: '$columnId = ?', whereArgs: [setting.id]);
        print("RESULT: $result");
    return result;
  }

  Future<int> deleteSetting(int id) async {
    var db = await this.database;
    int result =
        await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    return result;
  }

  close() async {
    var db = await this.database;
    var result = db.close();
    return result;
  }
}
