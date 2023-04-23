import 'package:check_internet_flutter_bloc_app/bloc/internet_bloc.dart';
import 'package:check_internet_flutter_bloc_app/cubit/internet_connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home_cubit_page.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBloc>(
          create: (_) => InternetBloc(),
        ),
        BlocProvider<InternetConnectionCubit>(
          create: (_) => InternetConnectionCubit(),
        )
      ],
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageCubit(),
    );
  }
}
