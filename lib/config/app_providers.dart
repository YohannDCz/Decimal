import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Bloc extends StatelessWidget {
  const Bloc({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationService(supabaseClient: Supabase.instance.client),
      child: BlocProvider(
        create: (context) => AuthenticationBloc(authenticationService: context.read<AuthenticationService>()),
        child: child,
      ),
    );
  }
}
