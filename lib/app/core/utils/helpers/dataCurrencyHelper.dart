import 'package:chimba_wallet/app/data/model/setting_currency.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataCurrencyHelper {
  static Database? _walletDb;
  static DataCurrencyHelper? _dataCurrencyHelper;

  static final databaseName = "chimbaWallet.db";
  static final _databaseVersion = 1;
  static final table = 'currency';
  static final columnId = 'id';
  static final columnCurrency = 'currency';
  static final columnStatus = 'status';
  static final columnPrice = 'price';

  DataCurrencyHelper._createInstance();

  static final DataCurrencyHelper db = DataCurrencyHelper._createInstance();

  factory DataCurrencyHelper() {
    _dataCurrencyHelper ??= DataCurrencyHelper._createInstance();
    return _dataCurrencyHelper!;
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

  /*Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + databaseName;
    var myDatabase = await openDatabase(path,
        version: _databaseVersion, onCreate: _createDb);
    return myDatabase;
  }*/

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnCurrency TEXT, $columnStatus BOOL, $columnPrice INT)");
  }

  Future<List<Map<String, Object?>>> getCurrencyMapList() async {
    Database db = await database;
    var result = await db.query(table, orderBy: "$columnId ASC");
    return result;
  }

  Future<int> insertCurrency(SettingCurrency settingCurrency) async {
    Database db = await this.database;
    var result = await db.insert(table, settingCurrency.toMap());
    return result;
  }

  Future<int> updateCurrency(SettingCurrency settingCurrency) async {
    var db = await this.database;
    var result = await db.update(table, settingCurrency.toMap(),
        where: '$columnId = ?', whereArgs: [settingCurrency.id]);
    return result;
  }

  Future<int> deleteCurrency(int id) async {
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

//how  
