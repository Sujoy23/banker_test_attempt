import 'package:equatable/equatable.dart';

abstract class StatementState extends Equatable {
  const StatementState();

  @override
  List<Object> get props => [];
}

class StatementInitial extends StatementState {}

class StatementLoading extends StatementState {}

class StatementLoaded extends StatementState {
  final dynamic data;

  StatementLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class StatementError extends StatementState {
  final String message;

  StatementError(this.message);

  @override
  List<Object> get props => [message];
}
