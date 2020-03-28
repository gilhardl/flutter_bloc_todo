import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class Authenticated extends AuthState {
  final String userId;
  final String displayName;

  Authenticated(this.userId, this.displayName);

  @override
  List<Object> get props => [userId, displayName];

  @override
  String toString() =>
      'Authenticated { userId: $userId, displayName: $displayName }';
}

class Unauthenticated extends AuthState {}
