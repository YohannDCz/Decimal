import 'package:decimal/config/constants.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:flutter/material.dart';

class ReactionService {
  Future<int> getReactions(String reactionType, int? publicationId) async {
    try {
      if (publicationId == null) {
        return 0;
      }
      final response = await supabaseClient.from(reactionType).select().eq('publication_id', publicationId);
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
    var response = await supabaseClient.from('publications').select().eq('id', publicationId).eq('user_uuid_repost', null).single();
    var publication = PublicationModel.fromMap(response as Map<String, dynamic>);
    var responseItem = await supabaseClient.from(publication.type).select().eq('publication_id', publicationId).single();
    var publicationItem = PublicationItemModel.fromMap(responseItem as Map<String, dynamic>);

    try {
      await supabaseClient.from('publications').insert([
        {
          'user_uuid': publication.user_uuid,
          'type': publication.type,
          'location': publication.location,
          'date_of_publication': DateTime.now().toIso8601String(),
          'user_uuid_repost': supabaseUser!.id,
        }
      ]);
      
      if (publication.type == 'posts' || publication.type == 'pics') {
        await supabaseClient.from(publication.type).insert([
          {
            'publication_id': publication.id,
            'content': publicationItem.content,
            'url': publicationItem.url,
            'tags': publicationItem.tags,
            'is_repost': true,
          }
        ]);
      } else if (publication.type == 'videos' || publication.type == 'stories') {
        await supabaseClient.from(publication.type).insert([
          {
            'publication_id': publication.id,
            'content': publicationItem.content,
            'url': publicationItem.url,
            'tags': publicationItem.tags,
            'title': publicationItem.title,
            'duration': publicationItem.duration,
            'is_repost': true,

          }
        ]);
      }

      var response = await supabaseClient.from('publications').select().eq('user_uuid', publication.user_uuid).eq('type', publication.type).eq('location', publication.location).eq('user_uuid_repost', supabaseUser!.id).single();
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

  Future removeRepost(int publicationId) async {
    try {
      await supabaseClient.from('reposts').delete().eq('publication_id', publicationId).eq('user_uuid', supabaseUser!.id);
      await supabaseClient.from('publications').delete().eq('user_uuid_repost', supabaseUser!.id).eq('id', publicationId);
      await supabaseClient.from('posts').delete().eq('publication_id', publicationId);
      await supabaseClient.from('pics').delete().eq('publication_id', publicationId);
      await supabaseClient.from('videos').delete().eq('publication_id', publicationId);
    } catch (e) {
      debugPrint('Unable to remove the repost: $e');
      throw Exception('Unable to remove the repost: $e');
    }
  }
}
