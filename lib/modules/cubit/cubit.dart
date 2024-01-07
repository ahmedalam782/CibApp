import 'package:cib/modules/cubit/state.dart';
import 'package:cib/modules/detail_transfer_modules.dart';
import 'package:cib/modules/home_modules.dart';
import 'package:cib/modules/transfer_modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/components/database_Login_register/database_components.dart';
import '../../shared/constant/constant.dart';

class CibCubit extends Cubit<CibState> {
  CibCubit() : super(CibInitialState());

  static CibCubit get(context) => BlocProvider.of(context);
  List<Widget> screen = [
    HomeModules(),
    TransfersModules(),
    RequestsModules(),
  ];
  bool isPressedChangeCurrency = false;
  List<Map> transfer = [];

  bool changeShowPassword(bool password) {
    if (password) {
      password = false;
    } else {
      password = true;
    }
    emit(CibChangePasswordState());
    return password;
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(CibChangeBottomNavBarState());
  }

  void changeCurrencyValue(double value) {
    currencyValue = value.round().toDouble();
    emit(CibChangeCurrencyValue());
  }

  void changePressedIcon(double value) {
    if (currencyValue < value) {
      currencyValue++;
    } else if (currencyValue > value) {
      currencyValue--;
    }
    emit(CibChangeCurrencyValuePressedIcon());
  }

  bool changeCurrencyCalculator(bool isPressedChangeCurrency) {
    if (isPressedChangeCurrency) {
      isPressedChangeCurrency = false;
    } else {
      isPressedChangeCurrency = true;
    }
    emit(CibChangeCurrencyCalculator());
    return isPressedChangeCurrency;
  }

  void initDatabase() async {
    return await openDatabase(DatabaseHelper.databaseName,
        version: DatabaseHelper.databaseVersion,
        onCreate: DatabaseHelper.onCreate, onOpen: (database) {
      print('Database opened');
    }).then((value) {
      emit(CibCreateDataBaseState());
      return DatabaseHelper.database = value;
    });
  }

  Future insertDatabase({
    required String name,
    required String phone,
    required String password,
    double currentBalance = 30000,
  }) async {
    return await DatabaseHelper.database.transaction(
      (txn) => txn
          .rawInsert(
              'INSERT INTO ${DatabaseHelper.customerTable}(name,phone,password,currentBalance) VALUES("$name","$phone","$password","$currentBalance")')
          .then((value) {
        emit(CibInsertDataBaseState());
        print('$value Inserted Completed');
      }).catchError((error) => print('${error.toString()}')),
    );
  }

  void getDataFromDatabase(database) {
    emit(CibGetDataBaseLoadingState());
    database
        .rawQuery('SELECT * FROM ${DatabaseHelper.customerTable}')
        .then((value) {
      value.forEach((element) {
        // for in loop
        if (element['phone'] == phoneEditingController.text) {
          phone = element['phone'];
        }
        if (element['name'] == usernameEditingController.text) {
          username = element['name'];
          phone = element['phone'];
          currentBalance = element['currentBalance'];
        }
        if (element['password'] == passwordEditingController.text) {
          password = element['password'];
        }
        if (element['phone'] == phoneEditingController.text &&
            element['name'] == usernameEditingController.text) {
          id = element[DatabaseHelper.customerId];
        }
        if (element['password'] == passwordEditingController.text &&
            element['name'] == usernameEditingController.text) {
          id = element[DatabaseHelper.customerId];
        }
      });
      emit(CibGetDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
  }

  void updateDatabase({required String password, required int id}) async {
    DatabaseHelper.database.rawUpdate(
        'UPDATE ${DatabaseHelper.customerTable} SET password=? WHERE ${DatabaseHelper.customerId}=?',
        [password, id]).then((value) {
      getDataFromDatabase(DatabaseHelper.database);
      emit(CibUpdateDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
  }

  void getDataFromDatabaseWhenTransfer(database) {
    emit(CibGetDataBaseLoadingState());
    database
        .rawQuery('SELECT * FROM ${DatabaseHelper.customerTable}')
        .then((value) {
      value.forEach((element) {
        // for in loop
        if (element['phone'] == phoneEditingController.text) {
          anotherCustomerPhone = element['phone'];
          anotherCustomerId = element[DatabaseHelper.customerId];
          anotherCustomerUsername = element['name'];
          currentOfAnotherBalance = element['currentBalance'];
        }
      });
      print(value);
      emit(CibGetDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
    database
        .rawQuery(
            "SELECT ${DatabaseHelper.customerId} FROM ${DatabaseHelper.customerTable} WHERE phone='$phone'")
        .then((value) {
      value.forEach((element) {
        id = element[DatabaseHelper.customerId];
      });
      emit(CibGetDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
    emit(CibGetTransferDataBaseLoadingState());
    database
        .rawQuery(
            "SELECT SUM(transferAmount) AS total FROM ${DatabaseHelper.transferTable} WHERE senderId='$id' AND date='${DateFormat.yMMMd().format(DateTime.now()).toString()}' ")
        .then((value) {
      value.forEach((element) {
        maxTransfer = element['total'];
      });
      emit(CibGetTransferDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
  }

  void getDataFromDatabaseTransfer(database) {
    emit(CibGetTransferDataBaseLoadingState());
    database
        .rawQuery("SELECT * FROM ${DatabaseHelper.transferTable} ")
        .then((value) {
      value.forEach((element) {
        transfer.add(element);
      });
      emit(CibGetTransferDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
  }

//////////////////////////////////
  Future insertTransferDatabase({
    required String senderId,
    required String receiverId,
    required String transferAmount,
    required String nameReceiver,
    required String phoneReceiver,
    required String nameSender,
    required String phoneSender,
  }) async {
    await DatabaseHelper.database.transaction(
      (txn) => txn
          .rawInsert(
              'INSERT INTO ${DatabaseHelper.transferTable}(receiverId,senderId,date,transferAmount,nameReceiver,phoneReceiver,nameSender,phoneSender) VALUES("$receiverId","$senderId","${DateFormat.yMMMd().format(DateTime.now()).toString()}","$transferAmount","$nameReceiver","$phoneReceiver","$nameSender","$phoneSender")')
          .then((value) {
        emit(CibInsertTransferDataBaseState());
        print('$value Inserted Completed');
      }).catchError((error) => print('${error.toString()}')),
    );
    DatabaseHelper.database.rawUpdate(
        'UPDATE ${DatabaseHelper.customerTable} SET currentBalance=? WHERE ${DatabaseHelper.customerId}=?',
        [currentBalance - double.parse(transferAmount), id]).then((value) {
      getDataFromDatabase(DatabaseHelper.database);
      emit(CibUpdateDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
    DatabaseHelper.database.rawUpdate(
        'UPDATE ${DatabaseHelper.customerTable} SET currentBalance=? WHERE ${DatabaseHelper.customerId}=?',
        [
          currentOfAnotherBalance + double.parse(transferAmount),
          anotherCustomerId
        ]).then((value) {
      getDataFromDatabase(DatabaseHelper.database);
      emit(CibUpdateDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
    DatabaseHelper.database
        .rawQuery(
            "SELECT currentBalance FROM ${DatabaseHelper.customerTable} WHERE phone='$phone'")
        .then((value) {
      value.forEach((element) {
        currentBalance = element['currentBalance'] as double;
      });
      emit(CibGetDataBaseState());
    }).catchError((error) => print('${error.toString()}'));
    transfer = [];
    getDataFromDatabaseTransfer(DatabaseHelper.database);
  }
}
