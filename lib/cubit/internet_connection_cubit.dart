import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  late StreamSubscription<ConnectivityResult> _internetSubscription;
  InternetConnectionCubit() : super(InternetConnectionLoading()) {
    _internetSubscription =
        Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        emit(InternetConnectionNotConnected());
      } else {
        _checkInternetConnection();
      }
    });
  }

  void _checkInternetConnection() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('example.com');
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      if (isConnected) {
        emit(InternetConnectionConnected());
      } else {
        emit(InternetConnectionNotConnected());
      }
    } on SocketException {
      emit(InternetConnectionNotConnected());
    }
  }

  @override
  Future<void> close() {
    _internetSubscription.cancel();
    return super.close();
  }
}
