import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/bloc/profile_content/profile_content_bloc.dart';
import 'package:decimal/bloc/reaction/reaction_bloc.dart';
import 'package:decimal/config/provider.dart';
import 'package:decimal/service/authentication_service.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:decimal/service/profile_content_service.dart';
import 'package:decimal/service/profile_service.dart';
import 'package:decimal/service/reaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Bloc extends StatelessWidget {
  const Bloc({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationService(supabaseClient: Supabase.instance.client),
        ),
        RepositoryProvider(
          create: (_) => ProfileContentService(),
        ),
        RepositoryProvider(
          create: (_) => FeedService(),
        ),
        RepositoryProvider(
          create: (_) => ProfileService(),
        ),
        RepositoryProvider(
          create: (_) => ReactionService(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(authenticationService: context.read<AuthenticationService>()),
            ),
            BlocProvider(
              create: (context) => ProfileContentBloc(profileContentService: context.read<ProfileContentService>()),
            ),
            BlocProvider(
              create: (context) => FeedBloc(feedService: context.read<FeedService>()),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(profileService: context.read<ProfileService>(), profileContentService: context.read<ProfileContentService>()),
            ),
            BlocProvider(
              create: (context) => ReactionBloc(reactionService: context.read<ReactionService>()),
            ),
          ],
          child: ChangeNotifierProvider(
            create: (context) => NavBar(),
            child: child,
          )),
    );
  }
}
