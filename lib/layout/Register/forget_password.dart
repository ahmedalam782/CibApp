import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/cubit/cubit.dart';
import '../../modules/cubit/state.dart';
import '../../shared/components/database_Login_register/database_components.dart';
import '../../shared/components/default_button.dart';
import '../../shared/components/default_form_field.dart';
import '../../shared/constant/constant.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = 'ForgetPasswordScreen';
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
            key: scaffoldKey,
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                title: Center(
                  child: Text(
                    'Forget/Reset Password',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                )),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Phone number',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DefaultTextFormField(
                      hintText: 'Phone number',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.left,
                      prefixIcon: Icons.phone,
                      controller: phoneEditingController,
                      textInputType: TextInputType.phone,
                      onChanged: (value) {
                        cubit.getDataFromDatabase(DatabaseHelper.database);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number must not be empty ';
                        }
                        if (value.length < 11) {
                          return 'Phone number must be 11 number';
                        }
                        if (value != phone) {
                          return "Phone number don't exist ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DefaultTextFormField(
                      hintText: 'Username',
                      controller: usernameEditingController,
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
                          return 'username is not correct try again ';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DefaultTextFormField(
                      controller: passwordEditingController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      hintText: 'Password',
                      textAlign: TextAlign.left,
                      obscureText: obscurePassword,
                      textInputType: TextInputType.number,
                      prefixIcon: Icons.lock,
                      suffixIcon: obscurePassword
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      onPressedSuffixIcon: () => obscurePassword =
                          cubit.changeShowPassword(obscurePassword),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        if (value.length < 6) {
                          return 'Password must equal 6 digits';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Confirm Password ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DefaultTextFormField(
                      controller: confirmPasswordEditingController,
                      hintText: 'Confirm Password',
                      textAlign: TextAlign.left,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputType: TextInputType.number,
                      obscureText: obscureConfirmPassword,
                      prefixIcon: Icons.lock,
                      suffixIcon: obscureConfirmPassword
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      onPressedSuffixIcon: () => obscureConfirmPassword =
                          cubit.changeShowPassword(obscureConfirmPassword),
                      validator: (value) {
                        if (value!.isEmpty ||
                            value != passwordEditingController.text) {
                          return 'Confirm password  must equal password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    DefaultButton(
                      child: Text(
                        "Reset your Password",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      width: double.infinity,
                      backgroundColorButton: Color(0xffF06A00),
                      height: 50,
                      onPressed: () => resetPassword(context),
                    )
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

  void resetPassword(BuildContext context) {
    cubit.getDataFromDatabase(DatabaseHelper.database);
    if (formKey.currentState!.validate()) {
      cubit.updateDatabase(
        id: id,
        password: passwordEditingController.text,
      );
      phoneEditingController.clear();
      usernameEditingController.clear();
      passwordEditingController.clear();
      confirmPasswordEditingController.clear();
      Navigator.pop(context);
    }
  }
}
