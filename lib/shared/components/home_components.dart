import 'package:cib/modules/cubit/cubit.dart';
import 'package:cib/modules/currency_calculator_screen.dart';
import 'package:cib/modules/transfer_money_screen.dart';
import 'package:cib/shared/components/Home_quick_links.dart';
import 'package:cib/shared/components/database_Login_register/database_components.dart';
import 'package:flutter/material.dart';

class HomeComponents extends StatelessWidget {
  String phonenumber;
  double currentBalance;

  HomeComponents({required this.phonenumber, required this.currentBalance});

  @override
  Widget build(BuildContext context) {
    List<Widget> quickLinkView = [
      HomeQuickLinkComponents(
          icon: Icons.compare_arrows,
          text: 'Transfer \n Money ',
          onTap: () {
            CibCubit.get(context)
                .getDataFromDatabaseWhenTransfer(DatabaseHelper.database);
            return Navigator.pushNamed(context, TransferMoneyScreen.routeName);
          }),
      HomeQuickLinkComponents(
        icon: Icons.credit_card,
        text: 'Credit \nCard \nPayments',
      ),
      HomeQuickLinkComponents(
        icon: Icons.send_to_mobile,
        text: 'Request New \nCheque Book',
      ),
      HomeQuickLinkComponents(
        icon: Icons.currency_exchange,
        text: 'Currency \nCalculator',
        onTap: () => Navigator.pushNamed(context, CurrencyCalculator.routeName),
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'CIB Wallet',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Primary/Phone number account ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      phonenumber,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Credit Limit to Use ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      ' EGP ${currentBalance}',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      ' Credit Limit EGP 30000.00',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Quick Links',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 30,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) => quickLinkView[index],
              itemCount: quickLinkView.length,
            ),
          ),
        ],
      ),
    );
  }
}
