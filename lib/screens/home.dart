import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:decimal/screens/feed_.dart';
import 'package:decimal/screens/profile.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final List<Widget> _children;
  int _currentIndex = 0;

  bool isOffline = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checkConnectivity();
    });

    _children = [
      const Profile(),
      const Feed(),
      // const Offline(),
    ];
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _indexedStack(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  IndexedStack _indexedStack() {
    return IndexedStack(
        index: isOffline ? 3 : _currentIndex, // Si hors ligne, affichez l'écran hors connexion
        children: _children,
      );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
        backgroundColor: AppColors.black,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
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
      );
  }
}
