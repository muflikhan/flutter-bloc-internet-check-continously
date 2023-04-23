part of 'internet_connection_cubit.dart';

abstract class InternetConnectionState extends Equatable {
  const InternetConnectionState();

  @override
  List<Object> get props => [];
}

class InternetConnectionLoading extends InternetConnectionState {}

class InternetConnectionConnected extends InternetConnectionState {}

class InternetConnectionNotConnected extends InternetConnectionState {}
