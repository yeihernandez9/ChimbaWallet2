import 'package:chimba_wallet/app/data/model/book_address.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBookAddressHelper {
  static Database? _walletDb;
  static DataBookAddressHelper? _dataBookAddressHelper;

  static final databaseName = "chimbaWallet.db";
  static final _databaseVersion = 1;
  static final columnId = 'id';
  static final table = 'bookAddress';
  static final columnAddress = 'address';
  static final columnNickeName = 'nickname';
  static final columnDescription = 'description';

  DataBookAddressHelper._createInstance();

  static final DataBookAddressHelper db =
      DataBookAddressHelper._createInstance();

  factory DataBookAddressHelper() {
    _dataBookAddressHelper ??= DataBookAddressHelper._createInstance();
    return _dataBookAddressHelper!;
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
        "$columnNickeName TEXT, $columnAddress TEXT, $columnDescription TEXT)");
  }

  Future<List<Map<String, Object?>>> getBookAddressMapList() async {
    Database db = await database;
    var result = await db.query(table, orderBy: "$columnId ASC");
    return result;
  }

  Future<int> insertBookAddress(BookAddress bookAddress) async {
    Database db = await this.database;
    var result = await db.insert(table, bookAddress.toMap());
    return result;
  }

  Future<int> updateBookAddress(BookAddress bookAddress) async {
    var db = await this.database;
    var result = await db.update(table, bookAddress.toMap(),
        where: '$columnId = ?', whereArgs: [bookAddress.id]);
    return result;
  }

  Future<int> deleteBookAddress(int id) async {
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
