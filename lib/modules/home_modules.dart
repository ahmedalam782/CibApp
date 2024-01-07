import 'package:cib/modules/cubit/cubit.dart';
import 'package:cib/modules/cubit/state.dart';
import 'package:cib/shared/components/home_components.dart';
import 'package:cib/shared/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeModules extends StatelessWidget {
  late String securephone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CibCubit, CibState>(
      builder: (context, state) {
        makePhoneNotAllShow();
        return HomeComponents(
          phonenumber: securephone,
          currentBalance: currentBalance,
        );
      },
      listener: (context, state) {},
    );
  }

  void makePhoneNotAllShow() {
    List<String> phoneNumber = phone.split("");
    for (int i = 0; i < phoneNumber.length; i++) {
      if (i >= 3 && i <= 8) {
        phoneNumber[i] = '*';
      }
    }
    securephone = phoneNumber.join("");
  }
}
