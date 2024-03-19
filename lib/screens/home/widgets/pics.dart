import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pics extends StatefulWidget {
  const Pics({super.key});

  @override
  State<Pics> createState() => _PicsState();
}

class _PicsState extends State<Pics> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FeedBloc>(context).add(FetchPics());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight,
            child: Column(
              children: [
                height48,
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    if (state is FetchPicsSuccess) {
                      return Image.network(state.publicationItem[index].url ?? 'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg', fit: BoxFit.cover);
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
