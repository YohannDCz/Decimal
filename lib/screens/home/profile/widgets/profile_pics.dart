import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

class ProfilePics extends StatelessWidget {
  const ProfilePics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text('Pics'),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                ),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Image.network('https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg', fit: BoxFit.cover);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
