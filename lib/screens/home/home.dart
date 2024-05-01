import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/provider.dart';
import 'package:decimal/screens/home/feed/feed.dart';
import 'package:decimal/screens/home/profile/profile.dart';
import 'package:decimal/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final List<Widget> _children;
  bool isOffline = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checkConnectivity();
    });

    _children = [
      Profile(user_uuid: supabaseUser!.id),
      const Feed(),
      // const Offline(),
    ];
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isOffline = true;
      });
    } else {
      setState(() {
        isOffline = false;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex = Provider.of<NavBar>(context).currentIndex;

    return SafeArea(
      child: Scaffold(
        appBar: currentIndex == 0
            ? AppBar(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
                title: Text(currentIndex == 0 ? 'Profile' : "Feed", style: const TextStyle(fontWeight: FontWeight.bold)),
              )
            : const PreferredSize(preferredSize: Size(0, 0), child: SizedBox.shrink()),
        drawer: currentIndex == 0
            ? Drawer(
                backgroundColor: AppColors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // BlocProvider.of<AuthenticationBloc>(context).add(SignOut());
                        context.read<AuthenticationService>().logOut();
                        Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        body: IndexedStack(
          index: isOffline ? 3 : currentIndex, // Si hors ligne, affichez l'écran hors connexion
          children: _children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.black,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              Provider.of<NavBar>(context, listen: false).currentIndex = index;
            });
            print(currentIndex);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: AppColors.secondaryText),
              activeIcon: Icon(Icons.person, color: AppColors.white),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: AppColors.secondaryText),
              activeIcon: Icon(Icons.home, color: AppColors.white),
              label: 'Recherche',
            ),
          ],
        ),
      ),
    );
  }
}
