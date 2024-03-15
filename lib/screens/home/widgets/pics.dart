import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

class Pics extends StatelessWidget {
  const Pics({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight,
        child: Column(
          children: [
            height48,
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Image.network('https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg', fit: BoxFit.cover);
              },
            ),
          ],
        ),
      ),
    );
  }
}
