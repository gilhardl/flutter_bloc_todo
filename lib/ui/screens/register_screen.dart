import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/repositories/auth_repository.dart';
import 'package:bloc_todo/blocs/register/register_bloc.dart';

import 'package:bloc_todo/ui/widgets/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  final AuthRepository _authRepository;

  RegisterScreen({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authRepository: _authRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
