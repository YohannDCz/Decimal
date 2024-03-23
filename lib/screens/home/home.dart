import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/provider.dart';
import 'package:decimal/screens/home/feed/feed.dart';
import 'package:decimal/screens/home/profile/profile.dart';
import 'package:flutter/material.dart';
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
