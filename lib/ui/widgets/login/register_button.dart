import 'package:flutter/material.dart';

import 'package:bloc_todo/l10n/localizations.dart';
import 'package:bloc_todo/data/repositories/auth_repository.dart';

import 'package:bloc_todo/ui/screens/register_screen.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        BlocTodoLocalizations.of(context).register,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen();
          }),
        );
      },
    );
  }
}
