import 'package:cib/modules/cubit/cubit.dart';
import 'package:cib/modules/cubit/state.dart';
import 'package:cib/shared/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CibCubit, CibState>(
      builder: (context, state) {
        CibCubit cubit = CibCubit.get(context);
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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Image.asset(
                'assets/images/Bank_logo_real.png',
                width: 100,
              ),
              actions: [
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.account_circle_sharp,
                      color: Colors.white,
                      size: 40,
                    )),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: Colors.blue,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows),
                  label: 'Transfers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Transfer History',
                ),
              ],
            ),
            body: cubit.screen[currentIndex],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
