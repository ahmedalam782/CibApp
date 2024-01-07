import 'package:flutter/material.dart';

class HomeQuickLinkComponents extends StatelessWidget {
  IconData icon;
  String text;
  Function()? onTap;

  HomeQuickLinkComponents({required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
