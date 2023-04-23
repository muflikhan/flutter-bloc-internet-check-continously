import 'dart:async';

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
        emit(InternetConnectionConnected());
      }
    });
  }

  @override
  Future<void> close() {
    _internetSubscription.cancel();
    return super.close();
  }
}
