import 'package:decimal/config/app_providers.dart' as bloc;
import 'package:decimal/config/routes.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/feed/feed.dart';
import 'package:decimal/screens/home/profile/profile.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return bloc.Bloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routes: appRoutes,
        onGenerateRoute: generateRoute,
        // initialRoute: '/signin',
        home: const Feed(),
      ),
    );
  }
}
