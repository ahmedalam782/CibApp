import 'package:flutter/material.dart';

import '../components/default_login_bottom.dart';

List<Widget> gridView = [
  DefaultBottomBuild(
    text: 'IBN',
    icon: Icons.vpn_lock,
  ),
  DefaultBottomBuild(
    text: 'Tutorials',
    icon: Icons.phone_android,
  ),
  DefaultBottomBuild(
    text: 'Exchange Rates',
    icon: Icons.insert_chart_outlined,
  ),
  DefaultBottomBuild(
    text: 'Cib Bonus',
    icon: Icons.card_giftcard,
  ),
  DefaultBottomBuild(
    text: 'Offers',
    icon: Icons.local_offer_outlined,
  ),
  DefaultBottomBuild(
    text: 'More',
    icon: Icons.more_vert,
  ),
];
List<Widget> transferView = [
  DefaultBottomBuild(
    text: 'Request New Cheque Book',
    icon: Icons.request_quote,
  ),
  DefaultBottomBuild(
    text: 'Dispute Credit Card Transaction',
    icon: Icons.credit_score,
  ),
  DefaultBottomBuild(
    text: 'Inquiries-Suggestions-Complaints',
    icon: Icons.local_print_shop_outlined,
  ),
  DefaultBottomBuild(
    text: 'Stop Lost/Stolen Credit Card ',
    icon: Icons.back_hand_outlined,
  ),
  DefaultBottomBuild(
    text: 'Update Contact Information',
    icon: Icons.contact_phone_outlined,
  ),
  DefaultBottomBuild(
    text: 'Activation Token',
    icon: Icons.lock_clock_sharp,
  ),
];

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
GlobalKey<FormState> formKey = GlobalKey();
GlobalKey<ScaffoldState> scaffoldLoginKey = GlobalKey();
GlobalKey<FormState> formLoginKey = GlobalKey();
TextEditingController phoneEditingController = TextEditingController();
TextEditingController usernameEditingController = TextEditingController();
TextEditingController passwordEditingController = TextEditingController();
TextEditingController confirmPasswordEditingController =
    TextEditingController();
TextEditingController transferMoneyEditingController = TextEditingController();
String phone = '';
String anotherCustomerPhone = '';
String username = '';
String anotherCustomerUsername = '';
String password = '';
double currentBalance = 0;
int id = 0;
int anotherCustomerId = 0;
bool obscurePassword = true;
bool obscureConfirmPassword = true;
int currentIndex = 0;
bool isPressedChangeCurrency = false;
double currencyValue = 0;
double maxTransfer = 0;
double currentOfAnotherBalance = 0;
