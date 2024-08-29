import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/update_cart_body.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _cartTable = 'cart';

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $_cartTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      product_id TEXT,
      name TEXT,
      price INTEGER,
      quantity INTEGER,
      sub_total INTEGER
    )''');
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/maspos.db';

    Database db =
        await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<List<Map<String, dynamic>>> getCartProduct() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_cartTable);

    return results;
  }

  Future<int?> addProductToCart({required CartBody cartBody}) async {
    final db = await database;
    if (db != null) {
      final query = db.insert(_cartTable, cartBody.toJson());
      return query;
    } else {
      return null;
    }
  }

  Future<int?> updateCartProduct({
    required UpdateCartBody updateCartBody,
  }) async {
    final db = await database;
    if (db != null) {
      final query = await db.update(
        _cartTable,
        updateCartBody.toJson(),
        where: 'product_id = ?',
        whereArgs: [updateCartBody.productId],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return query;
    } else {
      return null;
    }
  }

  Future<int?> deleteCartProduct({required String productId}) async {
    final db = await database;
    if (db != null) {
      final query = db.delete(
        _cartTable,
        where: 'product_id = ?',
        whereArgs: [productId],
      );
      return query;
    } else {
      return null;
    }
  }
}
