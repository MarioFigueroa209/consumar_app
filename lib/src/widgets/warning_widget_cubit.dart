import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/check_internet_connection.dart';
import '../../utils/connection_status_cubit.dart';

class WarningWidgetCubit extends StatelessWidget {
  const WarningWidgetCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionStatusCubit(),
      child: BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
        builder: (context, status) {
          return Visibility(
              visible: status != ConnectionStatus.online,
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 60,
                color: Colors.red,
                child: const Row(
                  children: [
                    Icon(Icons.wifi_off),
                    SizedBox(
                      width: 8,
                    ),
                    Text("SIN CONEXIÓN A INTERNET.")
                  ],
                ),
              ));
        },
      ),
    );
  }
}
