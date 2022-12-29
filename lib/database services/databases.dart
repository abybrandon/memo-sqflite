// import 'dart:io';
// import 'package:db_slite/database%20services/productmodel.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseInstance {
//   final String _databaseName = 'db_ku.db';
//   final int _databaseVersion = 1;

//   // isi tabel
//   final String table = 'product';
//   final String id = 'id';
//   final String name = 'name';
//   final String category = 'category';
//   final String updatedAt = 'updatedAt';
//   final String createdAt = 'createdAt';

// // meng cek database apabila database kosong maka buat database, jika tidak maka
// //munculkan database
//   Database _database;

//   Future _onCreate(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $name TEXT, $category TEXT, $createdAt TEXT, $updatedAt TEXT)');
//   }

//   Future _initDatabase() async {
//     //ini fungsi saat aplikasi pertama dibuka ngambil database nya
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     //hasil pathnya
//     String path = join(documentDirectory.path, _databaseName);
//     return openDatabase(path, onCreate: _onCreate);
//   }

//   Future<Database> database() async {
//     if (_database == null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }

//   //list diambil dari mapping json query td
//   Future<List<ProductModel>> all() async {
//     //disini kita manggil hasil database yang sudah dimodel in
//     final data = await _database.query(table);
//     //tinggal mapiing dilist
//     List<ProductModel> result =
//         data.map((e) => ProductModel.fromJson(e)).toList();

//     return result;
//   }

//   //lalu membuat function menghandle insert data ke database
//   //return nya id yang product udh dibuat
//   //jadi ini menyimpan map peta ke database yang isinya diawal itu key dan value, key nya string
//   // dan valuenya dinamic , disimpan ke row
//   Future<int> insert(Map<String, dynamic> row) async {
//     final query = await _database.insert(table, row);
//     return query;
//   }
// }

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../screen/memomodel.dart';

class DbHelper {
  List<MemoClas> data = [];
  Database _db;
  final String _databaseName = 'db_ku1.db';
  //mengambil database yang akan datang , if jika database itu kosong, maka menunggu eksekusi dari
  //si fungsi initializedb itu nah klo initialize db itu udah selesai di eksekusi maka lanjut ke return db
  // yaitu mengembalikan koneksi ke database si fungsi initialize database tu dibawah
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

//fungsi ini mengembalikan database , jd database kita kan ditaro disebuah direktori
//nah kita mendeklarasikan dbpath yang dimana isinya join mengakses direktori tersebut getdatabasepath itu
//mencari direktori database yang sedang digunakan dengan nama database yang dimasukan
//var etrade adalah variable yang isinya fungsi opendatabase adalah mengambil nama databse sebelumnya
//nah apabila databse yang sebelumnya dicari tidak ada maka fungsi selanjutnya adalah oncreate
//mengembalikan fungsi membuat database di oncreate tersebut
  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), _databaseName);
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

//futureor bedanya dengan future adalah futureor akan mengembalikan atau tidak sama sekali nilai dimasa depan
//fungsi createdb itu dipanggil apabila diatas tidak menemukan datbase maka fungsi ini dipanggil
//fungsi ini mengembalikan 2 parameter yaitu database dan versi nya
//fungsi ini
  FutureOr<void> createDb(Database db, int version) async {
    await db.execute(
        "Create table memo(id integer primary key, title text, description text, warna text)");
  }

//jadi kan class Database tadi udah terkoneksi selanjutnya fungsi db.query adalah mengambil isi database
//berdasarkan isi nya yaitu table "product"
//list generate adalah fungsi yang mengembalikan sebuah list berdasarkan panjang list tersebut
//maka disini mengembalikan isi dari database itu
  Future<List> getMemo() async {
    Database db = await this.db;
    var result = await db.query("memo");
    //return result;
    return List.generate(result.length, (i) {
      return MemoClas.fromObject(result[i]);
    });
  }

  Future<int> insert(MemoClas memoClas) async {
    Database db = await this.db;
    var result = await db.insert("memo", memoClas.toMap());
    return result;
  }

//fungsi dimasa depan menghapus yang parameter nya id integer,
//awalnya menunggu database datang
//selanjutnya membuat variabeli result yang isinya menghapus table product berdasarkan id
  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from memo where id= $id");
    return result;
  }

  void searchData(String value, MemoClas memoclas) {
    // Filter data sesuai dengan teks yang diketik oleh pengguna
    List<MemoClas> filteredData =
        data.where((item) => item.title.contains(value)).toList();

    // Set ulang data yang akan ditampilkan pada search bar

    data = filteredData;
  }

  Future<void> update(MemoClas memoClas) async {
    Database db = await this.db;
    var result = await db.update("memo", memoClas.toMap(),
        where: "id=?", whereArgs: [memoClas.id]);
    return result;
  }
}
