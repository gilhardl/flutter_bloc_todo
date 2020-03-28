import 'package:flutter/material.dart';

import 'package:bloc_todo/data/repositories/auth_repository.dart';

import 'package:bloc_todo/ui/screens/register_screen.dart';

class RegisterButton extends StatelessWidget {
  final AuthRepository _authRepository;

  RegisterButton({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(authRepository: _authRepository);
          }),
        );
      },
    );
  }
}
