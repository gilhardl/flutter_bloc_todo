import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_todo/l10n/localizations.dart';
import 'package:bloc_todo/data/repositories/auth_repository.dart';
import 'package:bloc_todo/logic/blocs/register/register_bloc.dart';

import 'package:bloc_todo/ui/widgets/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(BlocTodoLocalizations.of(context).register)),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            authRepository: Provider.of<AuthRepository>(context, listen: false),
          ),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
