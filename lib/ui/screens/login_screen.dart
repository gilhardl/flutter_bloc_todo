import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/l10n/localizations.dart';
import 'package:bloc_todo/data/repositories/auth_repository.dart';
import 'package:bloc_todo/logic/blocs/login/login_bloc.dart';

import 'package:bloc_todo/ui/widgets/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _authRepository;

  LoginScreen({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(BlocTodoLocalizations.of(context).login)),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authRepository: _authRepository),
        child: LoginForm(authRepository: _authRepository),
      ),
    );
  }
}
