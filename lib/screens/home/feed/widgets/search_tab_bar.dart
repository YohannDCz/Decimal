import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class SearchTabBar extends StatelessWidget {
  const SearchTabBar({
    super.key,
    required bool afficherTabBar,
    required TabController tabController,
    required FocusNode searchBarFocusNode,
  })  : _displayTabBar = afficherTabBar,
        _tabController = tabController,
        _searchBarFocusNode = searchBarFocusNode;

  final bool _displayTabBar;
  final TabController _tabController;
  final FocusNode _searchBarFocusNode;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500), // Durée de l'animation
      curve: Curves.easeInOut, // Type d'animation, ajustez selon vos préférences
      top: _displayTabBar ? 0 : -50, // Changez -50 à la hauteur négative de votre TabBar pour la cacher
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white, // Ajustez selon votre thème
        child: Column(
          children: [
            TextField(
              focusNode: _searchBarFocusNode,
              decoration: InputDecoration(
                hintText: "What's new with you ? ...",
                hintStyle: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.accent3),
                alignLabelWithHint: true,
                prefixIcon: IconButton(splashColor: AppColors.alternate, icon: Icon(Icons.arrow_downward, color: AppColors.accent3), onPressed: () {}),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 4),
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    Icons.search,
                    color: AppColors.white,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                ),
              ),
            ),
            Container(
              color: AppColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Ajuste l'espacement
                children: <Widget>[
                  IconButton(splashColor: Colors.transparent, icon: const Icon(Icons.feed), onPressed: () => _tabController.animateTo(0)),
                  IconButton(splashColor: Colors.transparent, icon: const Icon(Icons.play_circle), onPressed: () => _tabController.animateTo(1)),
                  IconButton(splashColor: Colors.transparent, icon: const Icon(FontAwesomeIcons.youtube), onPressed: () => _tabController.animateTo(2)),
                  IconButton(splashColor: Colors.transparent, icon: const Icon(Icons.image), onPressed: () => _tabController.animateTo(3)),
                  IconButton(splashColor: Colors.transparent, icon: const Icon(Icons.email), onPressed: () => _tabController.animateTo(4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
