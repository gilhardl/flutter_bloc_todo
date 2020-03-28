import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class Authenticated extends AuthState {
  final String displayName;

  Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class Unauthenticated extends AuthState {}
