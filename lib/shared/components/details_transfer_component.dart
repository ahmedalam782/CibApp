import 'package:cib/shared/constant/constant.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class DetailsTransferComponents extends StatelessWidget {
  Map trasfer;
  BuildContext context;

  DetailsTransferComponents({required this.trasfer, required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              username == trasfer['nameReceiver']
                  ? '+${trasfer['transferAmount']}'
                  : '-${trasfer['transferAmount']}',
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username == trasfer['nameReceiver']
                    ? 'transfer from ${trasfer['nameSender']} '
                    : 'To ${trasfer['nameReceiver']}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                username == trasfer['nameReceiver']
                    ? '${trasfer['phoneSender']} '
                    : '${trasfer['phoneReceiver']}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                '${trasfer['date']}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget taskBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) =>
            DetailsTransferComponents(trasfer: tasks[index], context: context),
        separatorBuilder: (context, index) => Divider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 60,
              color: Colors.grey,
            ),
            Text(
              'No transfer yet ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
