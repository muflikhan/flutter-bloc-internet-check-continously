import 'package:check_internet_flutter_bloc_app/cubit/internet_connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends StatelessWidget {
  const HomePageCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
      listener: (context, state) {
        if (state is InternetConnectionConnected) {
          _showSnackBar(context, 'Internet Connected');
        } else if (state is InternetConnectionNotConnected) {
          _showSnackBar(context, 'Internet Not Connected');
        }
      },
      builder: (_, state) {
        if (state is InternetConnectionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InternetConnectionConnected) {
          return const Center(
            child: Text('Internet Connected'),
          );
        } else if (state is InternetConnectionNotConnected) {
          return const Center(
            child: Text('Internet Not Connected'),
          );
        }
        return Container();
      },
    ));
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
