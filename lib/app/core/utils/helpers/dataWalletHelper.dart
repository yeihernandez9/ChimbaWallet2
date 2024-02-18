import 'dart:async';
import 'package:chimba_wallet/app/data/model/user_wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataWalletHelper {
  static Database? _walletDb;
  static DataWalletHelper? _dateWalletHelper;

  static final databaseName = "chimbaWallet.db";
  static final _databaseVersion = 1;

  static final table = 'userWallet';
  static final columnId = 'id';
  static final columnWallet = 'wallet';
  static final columnPass = 'password';
  static final columnAddress = 'address';
  static final columnMnemonic = 'mnemonic';

  static final tableCurrency = 'currency';
  static final columnCurrency = 'currency';
  static final columnStatus = 'status';
  static final columnPrice = 'price';

  static final tableSetting = 'setting';
  static final columnSetting = 'name';
  static final columnValue = 'value_status';
  static final columnDescription = 'description';

  static final tableBookAddress = 'bookAddress';
  static final columnNickeName = 'nickname';

  DataWalletHelper._createInstance();

  static final DataWalletHelper db = DataWalletHelper._createInstance();

  factory DataWalletHelper() {
    _dateWalletHelper ??= DataWalletHelper._createInstance();
    return _dateWalletHelper!;
  }

  Future<Database> get database async {
    _walletDb ??= await initializeDatabase();
    return _walletDb!;
  }

  initializeDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    print(path);
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
        "$columnWallet TEXT, $columnPass TEXT, $columnAddress TEXT, $columnMnemonic TEXT)");

    await db.execute("CREATE TABLE $tableCurrency"
        "($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnCurrency TEXT, $columnStatus BOOL, $columnPrice INT)");

    await db.execute("CREATE TABLE $tableSetting"
        "($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnSetting TEXT, $columnValue TEXT, $columnDescription TEXT)");

    await db.execute("CREATE TABLE $tableBookAddress"
        "($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnNickeName TEXT, $columnAddress TEXT, $columnDescription TEXT)");
  }

  Future<List<Map<String, dynamic>>> getUserWakketMapList() async {
    Database db = await database;
    var result = await db.query(table, orderBy: "$columnId ASC");
    return result;
  }

  Future<int> insertUserWallet(UserWallet userWallet) async {
    Database db = await this.database;
    var result = await db.insert(table, userWallet.toMap());
    return result;
  }

  Future<int> updateUserWallet(UserWallet userWallet) async {
    var db = await this.database;
    var result = await db.update(table, userWallet.toMap(),
        where: '$columnId = ?', whereArgs: [userWallet.id]);
    return result;
  }

  Future<int> deleteUserWallet(int id) async {
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
