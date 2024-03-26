import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileUserContacts extends StatefulWidget {
  const ProfileUserContacts({
    super.key,
  });

  @override
  State<ProfileUserContacts> createState() => _ProfileUserContactsState();
}

class _ProfileUserContactsState extends State<ProfileUserContacts> {
  late List<CustomUser>? contacts;

  @override
  initState() {
    super.initState();
    contacts = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is FetchProfileUserSuccess) {
          setState(() {
            contacts = state.fetchContactSuccess['contacts'];
          });
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: contacts!.isEmpty,
          child: Padding(
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
                    child: Text('Contacts'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        if (contacts != null && index < contacts!.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/profile', arguments: contacts![index].id);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Image.network(
                                      contacts![index].profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30.0,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.transparent, Colors.black],
                                        ),
                                      ),
                                      child: Text(
                                        contacts![index].name ?? '[contact_name]',
                                        style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Image.network(
                                    'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.0,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.transparent, Colors.black],
                                      ),
                                    ),
                                    child: Text(
                                      '[contact_name]',
                                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
