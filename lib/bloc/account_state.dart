import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final dynamic data;

  AccountLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class AccountError extends AccountState {
  final String message;

  AccountError(this.message);

  @override
  List<Object> get props => [message];
}
