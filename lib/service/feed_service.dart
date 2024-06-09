import 'package:decimal/config/constants.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';

class FeedService {
  Future<List<PublicationModel>> getPublications(String publication, int limit, {int offset = 0}) async {
    try {
      final response = await supabaseClient.from("publications").select().eq('type', publication).isFilter('user_uuid_original_publication', null).limit(limit).range(offset, offset + limit - 1).order('date_of_publication', ascending: false);
      final publicationModel = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      return publicationModel;
    } catch (e) {
      debugPrint('Unable to get $publication: $e');
      throw Exception('Unable to get $publication: $e');
    }
  }

  Future<List<PublicationItemModel>> getPublicationItems(String publication, int limit, {int offset = 0}) async {
    try {
      final List<PublicationModel> publications = await getPublications(publication, limit);
      final List<PublicationItemModel> publicationItems = [];
      for (var items in publications) {
        final response = await supabaseClient.from(publication).select().eq('publication_id', items.id!).single();
        final publicationModel = PublicationItemModel.fromMap(response);
        publicationItems.add(publicationModel);
      }
      return publicationItems;
    } catch (e) {
      debugPrint('Unable to get the publication or the $publication item: $e');
      throw Exception('Unable to get the publictoin or the $publication item: $e');
    }
  }

  Future<List<CustomUser>> getPublicationUsers(String publicationType, int limit, {int offset = 0}) async {
    try {
      // Obtention des publications filtrées par le type spécifié.
      final response = await supabaseClient.from('publications').select('users(*)').eq('type', publicationType).limit(limit).range(offset, offset + limit - 1).order('date_of_publication', ascending: false);
      List<CustomUser> publicationUsers = (response as List).map((e) => CustomUser.fromMap(e["users"] as Map<String, dynamic>)).toList();
      return publicationUsers;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des utilisateurs ou des publications : $e');
      throw Exception('Erreur lors de la récupération des utilisateurs ou des publications : $e');
    }
  }

  Future<List<List<CommentModel>>> getComments(String publicationType, int limit, {int offset = 0}) async {
    try {
      final response = await supabaseClient.from('publications').select('comments(*)').eq('type', publicationType).limit(limit).range(offset, offset + limit - 1).order('date_of_publication', ascending: false);
      final comments = (response as List).map((e) => (e["comments"] as List).map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList()).toList();
      return comments;
    } catch (e) {
      debugPrint('Unable to get the comments: $e');
      throw Exception('Unable to get the comments: $e');
    }
  }

  Future<List<List<CustomUser>>> getCommentUsers(String publicationType, int limit, {int offset = 0}) async {
    final allComments = await getComments(publicationType, limit);
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

  Future<List<PublicationModel>> getAllPublications({int offset = 0}) async {
    try {
      final response = await supabaseClient.from("publications").select().or('type.eq.posts,type.eq.pics,type.eq.videos').isFilter('user_uuid_original_publication', null).limit(5).range(offset, offset + 4).order('date_of_publication', ascending: false);
      final publicationModel = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      return publicationModel;
    } catch (e) {
      debugPrint('Unable to get all publications: $e');
      throw Exception('Unable to get all publications: $e');
    }
  }

  Future<List<PublicationItemModel>> getAllPublicationItems({int offset = 0}) async {
    try {
      final List<PublicationModel> publications = await getAllPublications();
      final List<PublicationItemModel> publicationItems = [];
      for (var items in publications) {
        final response = await supabaseClient.from(items.type).select().eq('publication_id', items.id!).single();
        final publicationModel = PublicationItemModel.fromMap(response);
        publicationItems.add(publicationModel);
      }
      return publicationItems;
    } catch (e) {
      debugPrint('Unable to get the publications or the publication item: $e');
      throw Exception('Unable to get the publictions or the publication item: $e');
    }
  }

  Future<List<CustomUser>> getAllPublicationUsers({int offset = 0}) async {
    try {
      // Obtention des publications filtrées par le type spécifié.
      final response = await supabaseClient.from('publications').select('users(*)').or('type.eq.posts,type.eq.pics,type.eq.videos').limit(5).range(offset, offset + 4).order('date_of_publication', ascending: false);
      List<CustomUser> publicationUsers = (response as List).map((e) => CustomUser.fromMap(e["users"] as Map<String, dynamic>)).toList();
      return publicationUsers;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des utilisateurs ou des publications : $e');
      throw Exception('Erreur lors de la récupération des utilisateurs ou des publications : $e');
    }
  }

  Future<List<List<CommentModel>>> getAllComments({int offset = 0}) async {
    try {
      final response = await supabaseClient.from('publications').select('comments(*)').limit(5).range(offset, offset + 4).order('date_of_publication', ascending: false);
      final comments = (response as List).map((e) => (e["comments"] as List).map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList()).toList();
      return comments;
    } catch (e) {
      debugPrint('Unable to get all the comments: $e');
      throw Exception('Unable to get all the comments: $e');
    }
  }

  Future<List<List<CustomUser>>> getAllCommentUsers({int offset = 0}) async {
    final allComments = await getAllComments(offset: offset);
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

  String? getDuration(DateTime? time) {
    final duration = DateTime(2029).difference(time!);
    if (duration.inDays > 365) {
      return "${(duration.inDays / 365).floor()}y"; // years
    } else if (duration.inDays >= 30) {
      return "${(duration.inDays / 30).floor()}mo"; // months
    } else if (duration.inDays >= 7) {
      return "${(duration.inDays / 7).floor()}w"; // weeks
    } else if (duration.inDays >= 1) {
      return "${duration.inDays}d"; // days
    } else if (duration.inHours >= 1) {
      return "${duration.inHours}h"; // hours
    } else if (duration.inMinutes >= 1) {
      return "${duration.inMinutes}m"; // minutes
    } else {
      return "${duration.inSeconds}s"; // seconds
    }
  }

  Future<Map<String, dynamic>> getStoriesData({int offset = 0}) async {
    try {
      final publications = await getPublications("stories", 5, offset: offset);
      final stories = await getPublicationItems("stories", 5, offset: offset);
      final users = await getPublicationUsers("stories", 5, offset: offset);
      final comments = await getComments("stories", 5, offset: offset);
      final commentsUsers = await getCommentUsers(
        "stories",
        5,
      );
      final storiesData = {'publications': publications, 'publicationItems': stories, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      return storiesData;
    } catch (e) {
      debugPrint('Unable to get the stories data: $e');
      throw Exception('Unable to get the stories data: $e');
    }
  }

  Future<Map<String, dynamic>> getPublicationData({int offset = 0}) async {
    try {
      final List<PublicationModel> publications = await getAllPublications(offset: offset);
      final List<PublicationItemModel> publicationItems = await getAllPublicationItems(offset: offset);
      final List<CustomUser> users = await getAllPublicationUsers(offset: offset);
      final List<List<CommentModel>> comments = await getAllComments(offset: offset);
      final List<List<CustomUser>> commentsUsers = await getAllCommentUsers(offset: offset);
      final Map<String, List<Object>> publicationData = {'publications': publications, 'publicationItems': publicationItems, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      return publicationData;
    } catch (e) {
      debugPrint('Unable to get the publication data: $e');
      throw Exception('Unable to get the publication data: $e');
    }
  }

  Future followUser(String userUuid) async {
    try {
      await supabaseClient.from('followings').insert([
        {
          'user_uuid': supabaseUser!.id,
          'contact_uuid': userUuid,
          'added_on': DateTime.now().toIso8601String(),
        }
      ]);
      await supabaseClient.from('followers').insert([
        {
          'user_uuid': userUuid,
          'contact_uuid': supabaseUser!.id,
          'added_on': DateTime.now().toIso8601String(),
        }
      ]);
    } catch (e) {
      debugPrint('Unable to follow the user: $e');
      throw Exception('Unable to follow the user: $e');
    }
  }

  Future unfollowUser(String userUuid) async {
    try {
      await supabaseClient.from('followings').delete().eq('user_uuid', supabaseUser!.id).eq('contact_uuid', userUuid);
      await supabaseClient.from('followers').delete().eq('user_uuid', userUuid).eq('contact_uuid', supabaseUser!.id);
    } catch (e) {
      debugPrint('Unable to unfollow the user: $e');
      throw Exception('Unable to unfollow the user: $e');
    }
  }

  Future<bool> isFollowed(String userUuid) async {
    try {
      final response = await supabaseClient.from('followings').select().eq('user_uuid', supabaseUser!.id).eq('contact_uuid', userUuid);
      return response.isNotEmpty;
    } catch (e) {
      debugPrint('Unable to check if the user is followed: $e');
      throw Exception('Unable to check if the user is followed: $e');
    }
  }
}
