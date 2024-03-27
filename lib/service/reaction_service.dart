import 'package:decimal/config/constants.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/reaction_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';

class ReactionService {
  Future<List<ReactionModel>> getReactions(String reactionType, int? publicationId) async {
    try {
      if (publicationId == null) {
        return [];
      }
      final response = await supabaseClient.from(reactionType).select().eq('publication_id', publicationId);
      return (response as List).map((e) => ReactionModel.fromMap(e as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint('Unable to get the reactions: $e');
      throw Exception('Unable to get the reactions: $e');
    }
  }

  Future<Map<String, dynamic>> getCommentsAndUsers(String reactionType, int? publicationId) async {
    try {
      if (publicationId == null) {
        return {};
      }
      final response = await supabaseClient.from(reactionType).select().eq('publication_id', publicationId);
      final reactionModel = response.map((e) => ReactionModel.fromMap(e as Map<String, dynamic>)).toList();
      final List<CustomUser> commentsUser = [];
      for (var item in reactionModel) {
        var userResponse = await supabaseClient.from('users').select().eq('uuid', item.user_uuid);
        var user = CustomUser.fromMap(userResponse.first as Map<String, dynamic>);
        commentsUser.add(user);
      }
      return {
        'comments': reactionModel,
        'users': commentsUser,
      };
    } catch (e) {
      debugPrint('Unable to get the comments: $e');
      throw Exception('Unable to get the comments: $e');
    }
  }

  Future<int> getReposts(int? publicationId) async {
    try {
      if (publicationId == null) {
        return 0;
      }
      final response = await supabaseClient.from('reposts').select().eq('publication_id_original', publicationId);
      return response.length;
    } catch (e) {
      debugPrint('Unable to get the reactions: $e');
      throw Exception('Unable to get the reactions: $e');
    }
  }

  Future addReaction(String reactionType, int publicationId) async {
    print(reactionType);
    try {
      final response = await supabaseClient.from(reactionType).insert([
        {
          'publication_id': publicationId,
          'user_uuid': supabaseUser!.id,
          'date_of_reaction': DateTime.now().toIso8601String(),
        }
      ]);
      return response;
    } catch (e) {
      debugPrint('Unable to add the reaction: $e');
      throw Exception('Unable to add the reaction: $e');
    }
  }

  Future removeReaction(String reactionType, int publicationId) async {
    try {
      final response = await supabaseClient.from(reactionType).delete().eq('publication_id', publicationId).eq('user_uuid', supabaseUser!.id);
      return response;
    } catch (e) {
      debugPrint('Unable to remove the reaction: $e');
      throw Exception('Unable to remove the reaction: $e');
    }
  }

  Future addComment(int publicationId, String comment) async {
    try {
      final response = await supabaseClient.from('comments').insert([
        {
          'publication_id': publicationId,
          'user_uuid': supabaseUser!.id,
          'content': comment,
          'date_of_comment': DateTime.now().toIso8601String(),
        }
      ]);
      return response;
    } catch (e) {
      debugPrint('Unable to add the comment: $e');
      throw Exception('Unable to add the comment: $e');
    }
  }

  Future addRepost(int publicationId) async {
    var response = await supabaseClient.from('publications').select().eq('id', publicationId).is_('user_uuid_original_publication', null).single();
    var publication = PublicationModel.fromMap(response as Map<String, dynamic>);

    try {
      await supabaseClient.from('publications').insert([
        {
          'user_uuid': supabaseUser!.id,
          'type': publication.type,
          'location': publication.location,
          'date_of_publication': DateTime.now().toIso8601String(),
          'user_uuid_original_publication': publication.user_uuid,
        }
      ]);

      var response = await supabaseClient.from('publications').select().eq('user_uuid', supabaseUser!.id).eq('type', publication.type).eq('location', publication.location).eq('user_uuid_original_publication', publication.user_uuid).single();
      var responseItem = PublicationItemModel.fromMap(response as Map<String, dynamic>);
      await supabaseClient.from('reposts').insert([
        {
          'user_uuid': supabaseUser!.id,
          'date_of_reaction': DateTime.now().toIso8601String(),
          'publication_id_original': publicationId,
          'publication_id': responseItem.id,
        }
      ]);

    } catch (e) {
      debugPrint('Unable to add the repost: $e');
      throw Exception('Unable to add the repost: $e');
    }
  }
}
