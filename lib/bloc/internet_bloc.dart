import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetLoading()) {
    _internetSubscription =
        Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        add(InternetNotConnectedEvent());
      } else {
        _checkInternetConnection();
      }
    });
    on<InternetConnectedEvent>(_onInternetConnectedEvent);
    on<InternetNotConnectedEvent>(_onInternetNotConnectedEvent);
  }

  late StreamSubscription<ConnectivityResult> _internetSubscription;
  @override
  Future<void> close() {
    _internetSubscription.cancel();
    return super.close();
  }

  void _onInternetConnectedEvent(
      InternetConnectedEvent event, Emitter<InternetState> emit) {
    emit(InternetConnected());
  }

  void _onInternetNotConnectedEvent(
      InternetNotConnectedEvent event, Emitter<InternetState> emit) {
    emit(InternetNotConnected());
  }

  void _checkInternetConnection() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('example.com');
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      if (isConnected) {
        add(InternetConnectedEvent());
      } else {
        add(InternetNotConnectedEvent());
      }
    } on SocketException {
      add(InternetNotConnectedEvent());
    }
  }
}
