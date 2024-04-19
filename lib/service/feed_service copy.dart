import 'package:decimal/config/constants.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:postgrest/src/types.dart';

class FeedService {
  Future<List<PublicationModel>> getPublications(int limit, {String? publicationType}) async {
    late final PostgrestList response;
    try {
      if (publicationType != null) {
        response = await supabaseClient.from("publications").select().eq('type', publicationType).isFilter('user_uuid_original_publication', null).limit(limit).order('date_of_publication', ascending: false);
      } else {
        response = await supabaseClient.from("publications").select().isFilter('user_uuid_original_publication', null).limit(limit).order('date_of_publication', ascending: false);
      }
      final publicationModels = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      return publicationModels;
    } catch (e) {
      debugPrint('Unable to get publications: $e');
      throw Exception('Unable to get publications: $e');
    }
  }

  Future<PublicationItemModel> getPublicationItem(int publicationId) async {
    try {
      final publicationResponse = await supabaseClient.from("publications").select().eq('id', publicationId).single();
      final publication = PublicationModel.fromMap(publicationResponse);

      final itemResponse = await supabaseClient.from(publication.type).select().eq('publication_id', publicationId).single();
      final publicationItem = PublicationItemModel.fromMap(itemResponse);

      return publicationItem;
    } catch (e) {
      debugPrint('Unable to get publication item: $e');
      throw Exception('Unable to get publication item: $e');
    }
  }

  Future<CustomUser> getPublicationUser(String userUuid) async {
    try {
      final response = await supabaseClient.from('users').select().eq('uuid', userUuid).single();
      return CustomUser.fromMap(response);
    } catch (e) {
      debugPrint('Unable to get publication user: $e');
      throw Exception('Unable to get publication user: $e');
    }
  }

  Future<List<CommentModel>> getComments(int publicationId) async {
    try {
      final response = await supabaseClient.from('comments').select().eq('publication_id', publicationId);
      final comments = (response as List).map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList();
      return comments;
    } catch (e) {
      debugPrint('Unable to get comments: $e');
      throw Exception('Unable to get comments: $e');
    }
  }

  Future<CustomUser> getCommentUser(String userUuid) async {
    try {
      final response = await supabaseClient.from('users').select().eq('uuid', userUuid).single();
      return CustomUser.fromMap(response);
    } catch (e) {
      debugPrint('Unable to get comment user: $e');
      throw Exception('Unable to get comment user: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPublicationsWithDetails(int limit, {String? publicationType}) async {
    try {
      final publications = await getPublications(publicationType: publicationType, limit);
      final publicationsWithDetails = await Future.wait(publications.map((publication) async {
        final publicationItem = await getPublicationItem(publication.id!);
        final publicationUser = await getPublicationUser(publication.user_uuid!);
        final comments = await getComments(publication.id!);
        final commentUsers = await Future.wait(comments.map((comment) async {
          final commentUser = await getCommentUser(comment.user_uuid);
          return {"comment": comment, "user": commentUser};
        }));
        return {
          "publication": publication,
          "publicationItem": publicationItem,
          "user": publicationUser,
          "comments": comments,
          "commentUsers": commentUsers,
        };
      }));
      return publicationsWithDetails;
    } catch (e) {
      debugPrint('Unable to get publications with details: $e');
      throw Exception('Unable to get publications with details: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getStoriesData() async {
    try {
      final storiesData = getPublicationsWithDetails(5, publicationType: 'stories');
      return storiesData;
    } catch (e) {
      debugPrint('Unable to get the stories data: $e');
      throw Exception('Unable to get the stories data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPublicationData() async {
    try {
      final publicationsData = getPublicationsWithDetails(5);
      return publicationsData;
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
}
