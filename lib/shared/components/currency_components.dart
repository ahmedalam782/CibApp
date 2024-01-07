import 'package:flutter/material.dart';

class CurrencyComponent extends StatelessWidget {
  String title;
  String image;
  String nameOfCurrency;

  CurrencyComponent(
      {required this.title, required this.image, required this.nameOfCurrency});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.blue[60],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(children: [
            Image.network(image),
            Text(
              nameOfCurrency,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
