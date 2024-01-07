import 'package:cib/modules/cubit/cubit.dart';
import 'package:cib/modules/cubit/state.dart';
import 'package:cib/shared/components/details_transfer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsModules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CibCubit, CibState>(
      builder: (context, state) {
        var transfer = CibCubit.get(context).transfer;
        return taskBuilder(tasks: transfer);
      },
      listener: (context, state) {},
    );
  }
}
