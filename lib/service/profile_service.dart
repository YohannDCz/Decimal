// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:decimal/config/constants.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/contact_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/reaction_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  Future<List<PublicationModel>> getPublications(String publication, String user_uuid) async {
    try {
      final response = await supabaseClient.from("publications").select().eq('type', publication).eq('user_uuid', user_uuid).limit(5).order('date_of_publication', ascending: false);
      final publicationModel = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      return publicationModel;
    } catch (e) {
      debugPrint('Unable to get $publication: $e');
      throw Exception('Unable to get $publication: $e');
    }
  }

  Future<List<PublicationItemModel>> getPublicationItems(String publication, String user_uuid) async {
    try {
      final List<PublicationModel> publications = await getPublications(publication, user_uuid);
      log(publications.toString());
      final List<PublicationItemModel> publicationItems = [];
      for (var item in publications) {
        if (item.user_uuid_original_publication != null) {
          final response = await supabaseClient.from("reposts").select().eq('publication_id', item.id!).single();
          final repostModel = ReactionModel.fromMap(response);
          final response1 = await supabaseClient.from(publication).select().eq('publication_id', repostModel.publication_id_original!).single();
          final publicationModel = PublicationItemModel.fromMap(response1);
          publicationItems.add(publicationModel);
        } else {
          final response = await supabaseClient.from(publication).select().eq('publication_id', item.id!).single();
          final publicationModel = PublicationItemModel.fromMap(response);
          publicationItems.add(publicationModel);
        }
      }
      return publicationItems;
    } catch (e) {
      debugPrint('Unable to get the publication or the $publication item: $e');
      throw Exception('Unable to get the publication or the $publication item: $e');
    }
  }

  Future<List<CustomUser>> getPublicationUsers(String publicationType, String user_uuid) async {
    try {
      // Obtention des publications filtrées par le type spécifié.
      final response = await supabaseClient.from('publications').select('users(*)').eq('type', publicationType).eq('user_uuid', user_uuid).limit(5).order('date_of_publication', ascending: false);
      List<CustomUser> publicationUsers = (response as List).map((e) => CustomUser.fromMap(e["users"] as Map<String, dynamic>)).toList();
      return publicationUsers;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des utilisateurs ou des publications : $e');
      throw Exception('Erreur lors de la récupération des utilisateurs ou des publications : $e');
    }
  }

  Future<List<List<CommentModel>>> getComments(String publicationType, String user_uuid) async {
    try {
      final response = await supabaseClient.from('publications').select('comments(*)').eq('type', publicationType).eq('user_uuid', user_uuid).limit(5).order('date_of_publication', ascending: false);
      final comments = (response as List).map((e) => (e["comments"] as List).map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList()).toList();
      return comments;
    } catch (e) {
      debugPrint('Unable to get the comments: $e');
      throw Exception('Unable to get the comments: $e');
    }
  }

  Future<List<List<CustomUser>>> getCommentUsers(String publicationType, String user_uuid) async {
    final allComments = await getComments(publicationType, user_uuid);
    final List<List<CustomUser>> allUsers = [];
    try {
      for (var comments in allComments) {
        final List<CustomUser> allUserComments = [];
        for (var comment in comments) {
          final response = await supabaseClient.from('users').select().eq('uuid', comment.user_uuid).single();
          final CustomUser user = CustomUser.fromMap(response);
          allUserComments.add(user);
        }
        allUsers.add(allUserComments);
      }
      return allUsers;
    } catch (e) {
      debugPrint('Unable to get all the comments: $e');
      throw Exception('Unable to get all the comments: $e');
    }
  }

  Future<List<PublicationModel>> getAllPublications(String user_uuid) async {
    try {
      final response = await supabaseClient.from("publications").select().eq('user_uuid', user_uuid).or('type.eq.posts, type.eq.pics, type.eq.videos').limit(5).order('date_of_publication', ascending: false);

      final publicationModel = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      return publicationModel;
    } catch (e) {
      debugPrint('Unable to get all publications: $e');
      throw Exception('Unable to get all publications: $e');
    }
  }

  Future<List<PublicationItemModel>> getAllPublicationItems(String user_uuid) async {
    final List<PublicationModel> publications = await getAllPublications(user_uuid);
    if (publications.isEmpty) {
      return [];
    }
    final List<PublicationItemModel> publicationItems = [];
    Map<String, dynamic> response;
    ReactionModel repostModel;
    Map<String, dynamic> response1;
    PublicationItemModel publicationModel;
    for (var item in publications) {
      if (item.is_repost == true) {
        try {
          response = await supabaseClient.from("reposts").select().eq('publication_id', item.id!).single();
          repostModel = ReactionModel.fromMap(response);
        } catch (e) {
          debugPrint('Unable to get the repost: $e');
          throw Exception('Unable to get the repost: $e');
        }
        try {
          response1 = await supabaseClient.from(item.type).select().eq('publication_id', repostModel.publication_id_original!).single();
          publicationModel = PublicationItemModel.fromMap(response1);
        } catch (e) {
          debugPrint('Unable to get the publication item where user_uuid_original_publication != null: $e');
          throw Exception('Unable to get the publication item: $e');
        }
        publicationItems.add(publicationModel);
      } else {
        try {
          final response = await supabaseClient.from(item.type).select().eq('publication_id', item.id!).single();
          final publicationModel = PublicationItemModel.fromMap(response);
          publicationItems.add(publicationModel);
        } catch (e) {
          debugPrint('Unable to get the publication item where user_uuid_original_publication == null: $e');
          throw Exception('Unable to get the publication item: $e');
        }
      }
    }
    return publicationItems;
  }

  Future<List<CustomUser>> getAllPublicationUsers(String user_uuid) async {
    try {
      // Obtention des publications filtrées par le type spécifié.
      final response = await supabaseClient.from('publications').select('users(*)').eq('user_uuid', user_uuid).or('type.eq.posts, type.eq.pics, type.eq.videos').limit(5).order('date_of_publication', ascending: false);
      List<CustomUser> publicationUsers = (response as List).map((e) => CustomUser.fromMap(e["users"] as Map<String, dynamic>)).toList();
      return publicationUsers;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des utilisateurs ou des publications : $e');
      throw Exception('Erreur lors de la récupération des utilisateurs ou des publications : $e');
    }
  }

  Future<List<List<CommentModel>>> getAllComments(String user_uuid) async {
    try {
      final response = await supabaseClient.from('publications').select('comments(*)').eq('user_uuid', user_uuid).limit(5).order('date_of_publication', ascending: false);
      final comments = (response as List).map((e) => (e["comments"] as List).map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList()).toList();
      return comments;
    } catch (e) {
      debugPrint('Unable to get all the comments: $e');
      throw Exception('Unable to get all the comments: $e');
    }
  }

  Future<List<List<CustomUser>>> getAllCommentUsers(String user_uuid) async {
    final allComments = await getAllComments(user_uuid);
    final List<List<CustomUser>> allUsers = [];
    try {
      for (var comments in allComments) {
        final List<CustomUser> allUserComments = [];
        for (var comment in comments) {
          final response = await supabaseClient.from('users').select().eq('uuid', comment.user_uuid).single();
          final CustomUser user = CustomUser.fromMap(response);
          allUserComments.add(user);
        }
        allUsers.add(allUserComments);
      }
      return allUsers;
    } catch (e) {
      debugPrint('Unable to get all the comments: $e');
      throw Exception('Unable to get all the comments: $e');
    }
  }

  Future<List<CustomUser>> getContacts(String contactType, String user_uuid) async {
    List<ContactModel> contacts = [];
    final List<CustomUser> users = [];

    try {
      final response = await supabaseClient.from(contactType).select().eq('user_uuid', user_uuid).limit(6);
      contacts = (response as List).map((e) => ContactModel.fromMap(e as Map<String, dynamic>)).toList();

      for (var contact in contacts) {
        final response = await supabaseClient.from('users').select('uuid, name, profile_picture').eq('uuid', contact.contact_uuid).single();
        final user = CustomUser.fromMap(response);
        users.add(user);
      }
      return users;
    } catch (e) {
      debugPrint('Unable to get the list of user: $e');
      throw Exception('Unable to get contacts: $e');
    }
  }

  Future<int> getContactsNumber(String contactType, String user_uuid) async {
    try {
      final countResponse = await supabaseClient.from(contactType).select().eq('user_uuid', user_uuid).count();
      final int count = (countResponse as PostgrestResponse).count;
      return count;
    } catch (e) {
      debugPrint('Unable to get the list of user: $e');
      throw Exception('Unable to get contacts: $e');
    }
  }

  Future<Map<String, dynamic>> getContactsData(String user_uuid) async {
    try {
      final List<CustomUser> contacts = await getContacts("contacts", user_uuid);
      final List<CustomUser> followers = await getContacts("followers", user_uuid);
      final List<CustomUser> followings = await getContacts("followings", user_uuid);
      final Map<String, dynamic> contactsData = {'contacts': contacts, 'followers': followers, 'followings': followings};
      return contactsData;
    } catch (e) {
      debugPrint('Unable to get the contacts data: $e');
      throw Exception('Unable to get the contacts data: $e');
    }
  }

  Future<Map<String, int>> getContactsNumberData(String user_uuid) async {
    try {
      final int contactsNumber = await getContactsNumber("contacts", user_uuid);
      final int followersNumber = await getContactsNumber("followers", user_uuid);
      final int followingsNumber = await getContactsNumber("followings", user_uuid);
      final Map<String, int> contactsNumberData = {'contacts': contactsNumber, 'followers': followersNumber, 'followings': followingsNumber};
      return contactsNumberData;
    } catch (e) {
      debugPrint('Unable to get the contacts number data: $e');
      throw Exception('Unable to get the contacts number data: $e');
    }
  }

  Future<Map<String, dynamic>> getStoriesData(String user_uuid) async {
    try {
      final List<PublicationModel> publications = await getPublications("stories", user_uuid);
      final List<PublicationItemModel> stories = await getPublicationItems("stories", user_uuid);
      final List<CustomUser> users = await getPublicationUsers("stories", user_uuid);
      final List<List<CommentModel>> comments = await getComments("stories", user_uuid);
      final List<List<CustomUser>> commentsUsers = await getCommentUsers("stories", user_uuid);
      final Map<String, dynamic> storiesData = {'publications': publications, 'stories': stories, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      return storiesData;
    } catch (e) {
      debugPrint('Unable to get the stories data: $e');
      throw Exception('Unable to get the stories data: $e');
    }
  }

  Future<Map<String, dynamic>> getPicsData(String user_uuid) async {
    try {
      final List<PublicationModel> publications = await getPublications("pics", user_uuid);
      final List<PublicationItemModel> pics = await getPublicationItems("pics", user_uuid);
      final List<CustomUser> users = await getPublicationUsers("pics", user_uuid);
      final List<List<CommentModel>> comments = await getComments("pics", user_uuid);
      final List<List<CustomUser>> commentsUsers = await getCommentUsers("pics", user_uuid);
      final Map<String, dynamic> picsData = {'publications': publications, 'pics': pics, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      return picsData;
    } catch (e) {
      debugPrint('Unable to get the pics data: $e');
      throw Exception('Unable to get the pics data: $e');
    }
  }

  Future<Map<String, dynamic>> getPublicationsData(String user_uuid) async {
    try {
      final List<PublicationModel> publications = await getAllPublications(user_uuid);
      final List<PublicationItemModel> publicationItems = await getAllPublicationItems(user_uuid);
      final List<CustomUser> users = await getAllPublicationUsers(user_uuid);
      final List<List<CommentModel>> comments = await getAllComments(user_uuid);
      final List<List<CustomUser>> commentsUsers = await getAllCommentUsers(user_uuid);
      final Map<String, dynamic> publicationData = {'publications': publications, 'publicationItems': publicationItems, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      return publicationData;
    } catch (e) {
      debugPrint('Unable to get the publication data: $e');
      throw Exception('Unable to get the publication data: $e');
    }
  }

  Future publishPublication(PublicationModel publications, PublicationItemModel publicationItems) async {
    int id = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    try {
      var publication = {
        'id': id,
        'type': publications.type,
        'date_of_publication': DateTime.now().toIso8601String(),
        'user_uuid': supabaseUser!.id,
        'user_uuid_original_publication': null,
        'location': publications.location,
        'is_repost': false,
      };
      await supabaseClient.from('publications').insert([publication]);
      Map<String, Object> publicationItem;

      if (publications.type == "posts" || publications.type == "pics") {
        publicationItem = {
          'publication_id': id,
          'content': publicationItems.content!,
          'url': publicationItems.url ?? "",
          'tags': publicationItems.tags ?? "",
        };
      } else if (publications.type == "videos") {
        publicationItem = {
          'publication_id': id,
          'content': publicationItems.content!,
          'url': publicationItems.url ?? "",
          'tags': publicationItems.tags ?? "",
          'duration': publicationItems.duration ?? 0,
          'title': publicationItems.title ?? "",
        };
      } else {
        publicationItem = {
          'publication_id': id,
          'content': publicationItems.content!,
          'url': publicationItems.url!,
          'tags': publicationItems.tags ?? "",
          'duration': publicationItems.duration!,
        };
      }
      await supabaseClient.from(publications.type).insert([publicationItem]);
    } catch (e) {
      debugPrint('Unable to publish the post: $e');
      throw Exception('Unable to publish the post: $e');
    }
  }
}
