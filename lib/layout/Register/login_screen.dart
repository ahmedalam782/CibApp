import 'package:cib/layout/Home/homeScreen.dart';
import 'package:cib/layout/Register/forget_password.dart';
import 'package:cib/layout/Register/register_screen.dart';
import 'package:cib/modules/cubit/cubit.dart';
import 'package:cib/modules/cubit/state.dart';
import 'package:cib/shared/components/default_button.dart';
import 'package:cib/shared/components/default_form_field.dart';
import 'package:cib/shared/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/database_Login_register/database_components.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'LoginScreen';
  late CibCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CibCubit, CibState>(
      builder: (context, state) {
        cubit = CibCubit.get(context);
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/mobile cover.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            key: scaffoldLoginKey,
            appBar: AppBar(
              title: Image.asset(
                'assets/images/Bank_logo_real.png',
                width: 100,
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formLoginKey,
                child: Column(
                  children: [
                    DefaultTextFormField(
                      controller: usernameEditingController,
                      labelText: Text(
                        'Username',
                        style: DefaultTextFormField.textStyle,
                      ),
                      textAlign: TextAlign.left,
                      prefixIcon: Icons.man,
                      onChanged: (value) {
                        cubit.getDataFromDatabase(DatabaseHelper.database);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username must not be empty ';
                        }
                        if (value != username) {
                          return ' Username is not correct';
                        } else {
                          return null;
                        }
                      },
                    ),
                    DefaultTextFormField(
                      controller: passwordEditingController,
                      labelText: Text(
                        'Password',
                        style: DefaultTextFormField.textStyle,
                      ),
                      textAlign: TextAlign.left,
                      prefixIcon: Icons.lock,
                      onChanged: (value) {
                        cubit.getDataFromDatabase(DatabaseHelper.database);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty ';
                        }
                        if (value != password) {
                          return 'password is not correct ';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            onPressed: () => login(context),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            width: double.maxFinite,
                            backgroundColorButton: Color(0xffF06A00),
                            height: 50,
                          ),
                        ),
                        DefaultButton(
                          child: Icon(
                            Icons.fingerprint,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {},
                          backgroundColorButton: Color(0xffF06A00),
                          height: 50,
                        ),
                      ],
                    ),
                    Center(
                      child: DefaultButton(
                        child: Text(
                          "Register New User",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                            context, RegisterScreen.routeName),
                        backgroundColorButton: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                    Center(
                      child: DefaultButton(
                        child: Text(
                          "Forget/Reset Password",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                            context, ForgetPasswordScreen.routeName),
                        marginVertical: 0,
                        backgroundColorButton: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (_, index) => gridView[index],
                      itemCount: gridView.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  void login(BuildContext context) {
    if (formLoginKey.currentState!.validate()) {
      cubit.getDataFromDatabase(DatabaseHelper.database);
      cubit.getDataFromDatabaseTransfer(DatabaseHelper.database);
      Navigator.popAndPushNamed(context, HomeScreen.routeName);
    }
  }
}
