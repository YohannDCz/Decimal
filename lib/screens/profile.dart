import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(SignOut());
        Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
      },
      child: const Text('SingOut'),
    );
  }
}
