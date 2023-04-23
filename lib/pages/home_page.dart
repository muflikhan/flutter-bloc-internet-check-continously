import 'package:check_internet_flutter_bloc_app/bloc/internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected) {
          _showSnackBar(context, 'Internet Connected');
        } else if (state is InternetNotConnected) {
          _showSnackBar(context, 'Internet Not Connected');
        }
      },
      builder: (context, state) {
        if (state is InternetLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InternetConnected) {
          return const Center(
            child: Text('Internet Connected'),
          );
        } else if (state is InternetNotConnected) {
          return const Center(
            child: Text('Internet Not Connected'),
          );
        }
        return const SizedBox.shrink();
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
