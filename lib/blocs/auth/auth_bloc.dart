import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:bloc_todo/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _authRepository.getUser();
        yield Authenticated(name);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    yield Authenticated(await _authRepository.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _authRepository.signOut();
  }
}
