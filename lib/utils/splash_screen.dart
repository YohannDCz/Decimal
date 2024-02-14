import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _redirectCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _redirect();
  }

  void _redirect() async {
    var session = Supabase.instance.client.auth.currentSession;
    if (_redirectCalled || !mounted) {
      return;
    }
    _redirectCalled = true;
    if (session != null) {
      Navigator.of(context).pushNamed('/home');
    } else {
      Navigator.of(context).pushNamed('/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
