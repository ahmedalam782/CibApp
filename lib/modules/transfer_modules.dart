import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/constant/constant.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class TransfersModules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CibCubit, CibState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(7.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 20,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (_, index) => transferView[index],
            itemCount: transferView.length,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
