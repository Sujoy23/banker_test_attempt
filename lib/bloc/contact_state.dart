import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final dynamic data;

  ContactLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ContactError extends ContactState {
  final String message;

  ContactError(this.message);

  @override
  List<Object> get props => [message];
}
