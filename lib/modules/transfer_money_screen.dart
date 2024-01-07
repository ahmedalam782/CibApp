import 'package:cib/modules/cubit/cubit.dart';
import 'package:cib/modules/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/database_Login_register/database_components.dart';
import '../shared/components/default_button.dart';
import '../shared/components/default_form_field.dart';
import '../shared/constant/constant.dart';

class TransferMoneyScreen extends StatelessWidget {
  static const String routeName = 'TransferMoneyScreen';
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
                onPressed: () {
                  phoneEditingController.clear();
                  transferMoneyEditingController.clear();
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Center(
                child: Text(
                  'Transfer Money',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
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
                        cubit.getDataFromDatabaseWhenTransfer(
                            DatabaseHelper.database);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number must not be empty ';
                        }
                        if (value.length < 11) {
                          return 'Phone number must be 11 number';
                        }
                        if (value == phone) {
                          return "It is not possible to transfer because the number transferred to it is identical to the sender's number";
                        }
                        if (value != anotherCustomerPhone) {
                          return "No account with this number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DefaultTextFormField(
                      hintText: 'Amount',
                      textAlign: TextAlign.left,
                      prefixIcon: Icons.attach_money,
                      controller: transferMoneyEditingController,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Amount must not be empty ';
                        } else {
                          return null;
                        }
                      },
                    ),
                    DefaultButton(
                      child: Text(
                        " Transfer ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      width: double.infinity,
                      backgroundColorButton: Color(0xffF06A00),
                      height: 50,
                      onPressed: () => transferMoney(context),
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

  void transferMoney(BuildContext context) {
    if (formKey.currentState!.validate()) {
      cubit.getDataFromDatabaseWhenTransfer(DatabaseHelper.database);
      if (currentBalance == 0 ||
          maxTransfer > 30000 ||
          double.parse(transferMoneyEditingController.text) + maxTransfer >
              30000) {
        showAlertDialog(context);
      } else {
        showAlertTransferDialog(context);
      }
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget OKButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text("you reach to you limit or you have no balance"),
      actions: [
        OKButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertTransferDialog(BuildContext context) {
    // set up the buttons
    Widget OKButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        cubit.insertTransferDatabase(
          senderId: '$id',
          receiverId: '$anotherCustomerId',
          transferAmount: transferMoneyEditingController.text,
          phoneReceiver: anotherCustomerPhone,
          nameReceiver: anotherCustomerUsername,
          phoneSender: phone,
          nameSender: username,
        );

        phoneEditingController.clear();
        transferMoneyEditingController.clear();
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text("Are you sure to transfer this money"),
      actions: [
        OKButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
