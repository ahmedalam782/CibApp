import 'package:cib/layout/Home/homeScreen.dart';
import 'package:cib/layout/Register/forget_password.dart';
import 'package:cib/layout/Register/login_screen.dart';
import 'package:cib/layout/Register/register_screen.dart';
import 'package:cib/modules/cubit/state.dart';
import 'package:cib/modules/currency_calculator_screen.dart';
import 'package:cib/modules/transfer_money_screen.dart';
import 'package:cib/shared/components/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/cubit/cubit.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(Cib());
}

class Cib extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CibCubit()..initDatabase(),
      child: BlocConsumer<CibCubit, CibState>(
        builder: (context, state) {
          return MaterialApp(
            routes: {
              LoginScreen.routeName: (context) => LoginScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              ForgetPasswordScreen.routeName: (context) =>
                  ForgetPasswordScreen(),
              CurrencyCalculator.routeName: (context) => CurrencyCalculator(),
              TransferMoneyScreen.routeName: (context) => TransferMoneyScreen(),
            },
            initialRoute: LoginScreen.routeName,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.transparent,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
