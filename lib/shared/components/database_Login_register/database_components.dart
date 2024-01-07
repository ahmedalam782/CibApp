import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = 'bank_db.db';
  static const databaseVersion = 1;
  static const customerTable = 'customer';
  static const transferTable = 'transfer';
  static const customerId = 'customerId';
  static const transferId = 'transferId';
  static late Database database;

  static Future onCreate(Database db, int version) async {
    await db
        .execute('''CREATE TABLE $customerTable (
          $customerId INTEGER PRIMARY KEY,
          name TEXT,
          phone TEXT,
          password Text,
          currentBalance REAL)
          ''')
        .then((value) => print('table created'))
        .catchError((error) => print('${error.toString()}'));

    await db
        .execute('''CREATE TABLE $transferTable (
          $transferId INTEGER PRIMARY KEY,
          receiverId INTEGER,
          nameReceiver TEXT,
          phoneReceiver TEXT,
          senderId INTEGER,
          nameSender TEXT,
          phoneSender TEXT,
          date Text,
          transferAmount REAL)
          ''')
        .then((value) => print('table created'))
        .catchError((error) => print('${error.toString()}'));
  }
}
