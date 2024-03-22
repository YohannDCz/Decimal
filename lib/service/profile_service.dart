// ignore_for_file: non_constant_identifier_names

import 'package:decimal/config/constants.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/contact_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';

class ProfileService {
  final supabaseUser = supabaseClient.auth.currentUser!.id;

  Future<List<PublicationModel>> getPublications(String publication) async {
    try {
      final response = await supabaseClient.from("publications").select().or('type.eq.$publication, user_uuid.eq.$supabaseUser').limit(18).order('date_of_publication', ascending: false);
      final publicationModel = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      return publicationModel;
    } catch (e) {
      print('Unable to get $publication: $e');
      throw Exception('Unable to get $publication: $e');
    }
  }

  Future<List<PublicationItemModel>> getPublicationItems(String publication) async {
    try {
      final List<PublicationModel> publications = await getPublications(publication);
      final List<PublicationItemModel> publicationItems = [];
      for (var items in publications) {
        final response = await supabaseClient.from(publication).select().eq('publication_id', items.id).single();
        final publicationModel = PublicationItemModel.fromMap(response as Map<String, dynamic>);
        publicationItems.add(publicationModel);
      }
      return publicationItems;
    } catch (e) {
      print('Unable to get the publication or the $publication item: $e');
      throw Exception('Unable to get the publictoin or the $publication item: $e');
    }
  }

  Future<List<CustomUser>> getPublicationUsers(String publicationType) async {
    try {
      // Obtention des publications filtrées par le type spécifié.
      final response = await supabaseClient.from('publications').select('users(*)').or('type.eq.$publicationType, user_uuid.eq.$supabaseUser').limit(18).order('date_of_publication', ascending: false);
      List<CustomUser> publicationUsers = (response as List).map((e) => CustomUser.fromMap(e["users"] as Map<String, dynamic>)).toList();
      return publicationUsers;
    } catch (e) {
      print('Erreur lors de la récupération des utilisateurs ou des publications : $e');
      throw Exception('Erreur lors de la récupération des utilisateurs ou des publications : $e');
    }
  }

  Future<List<List<CommentModel>>> getComments(String publicationType) async {
    try {
      final response = await supabaseClient.from('publications').select('comments(*)').or('type.eq.$publicationType, user_uuid.eq.$supabaseUser').limit(18).order('date_of_publication', ascending: false);
      final comments = (response as List).map((e) => (e["comments"] as List).map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList()).toList();
      return comments;
    } catch (e) {
      print('Unable to get the comments: $e');
      throw Exception('Unable to get the comments: $e');
    }
  }

  Future<List<List<CustomUser>>> getCommentUsers(String publicationType) async {
    final allComments = await getComments(publicationType);
    final List<List<CustomUser>> allUsers = [];
    try {
      for (var comments in allComments) {
        final List<CustomUser> allUserComments = [];
        for (var comment in comments) {
          final response = await supabaseClient.from('users').select().eq('uuid', comment.user_uuid).single();
          final CustomUser user = CustomUser.fromMap(response as Map<String, dynamic>);
          allUserComments.add(user);
        }
        allUsers.add(allUserComments);
      }
      return allUsers;
    } catch (e) {
      print('Unable to get all the comments: $e');
      throw Exception('Unable to get all the comments: $e');
    }
  }

  Future<List<PublicationModel>> getAllPublications() async {
    try {
      final response = await supabaseClient.from("publications").select().or('type.eq.posts, type.eq.pics, type.eq.videos, user_uuid.eq.$supabaseUser').limit(5).order('date_of_publication', ascending: false);
      final publicationModel = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      return publicationModel;
    } catch (e) {
      print('Unable to get all publications: $e');
      throw Exception('Unable to get all publications: $e');
    }
  }

  Future<List<PublicationItemModel>> getAllPublicationItems() async {
    try {
      final List<PublicationModel> publications = await getAllPublications();
      final List<PublicationItemModel> publicationItems = [];
      for (var items in publications) {
        final response = await supabaseClient.from(items.type).select().eq('publication_id', items.id).single();
        final publicationModel = PublicationItemModel.fromMap(response as Map<String, dynamic>);
        print(publicationModel);
        publicationItems.add(publicationModel);
      }
      print(publicationItems);
      return publicationItems;
    } catch (e) {
      print('Unable to get the publications or the publication item: $e');
      throw Exception('Unable to get the publictions or the publication item: $e');
    }
  }

  Future<List<CustomUser>> getAllPublicationUsers() async {
    try {
      // Obtention des publications filtrées par le type spécifié.
      final response = await supabaseClient.from('publications').select('users(*)').or('type.eq.posts, type.eq.pics, type.eq.videos, user_uuid.eq.$supabaseUser').limit(5).order('date_of_publication', ascending: false);
      List<CustomUser> publicationUsers = (response as List).map((e) => CustomUser.fromMap(e["users"] as Map<String, dynamic>)).toList();
      return publicationUsers;
    } catch (e) {
      print('Erreur lors de la récupération des utilisateurs ou des publications : $e');
      throw Exception('Erreur lors de la récupération des utilisateurs ou des publications : $e');
    }
  }

  Future<List<List<CommentModel>>> getAllComments() async {
    try {
      final response = await supabaseClient.from('publications').select('comments(*)').eq('user_uuid', supabaseUser).limit(5).order('date_of_publication', ascending: false);
      final comments = (response as List).map((e) => (e["comments"] as List).map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList()).toList();
      return comments;
    } catch (e) {
      print('Unable to get all the comments: $e');
      throw Exception('Unable to get all the comments: $e');
    }
  }

  Future<List<List<CustomUser>>> getAllCommentUsers() async {
    final allComments = await getAllComments();
    final List<List<CustomUser>> allUsers = [];
    try {
      for (var comments in allComments) {
        final List<CustomUser> allUserComments = [];
        for (var comment in comments) {
          final response = await supabaseClient.from('users').select().eq('uuid', comment.user_uuid).single();
          final CustomUser user = CustomUser.fromMap(response as Map<String, dynamic>);
          allUserComments.add(user);
        }
        allUsers.add(allUserComments);
      }
      return allUsers;
    } catch (e) {
      print('Unable to get all the comments: $e');
      throw Exception('Unable to get all the comments: $e');
    }
  }

  Future<List<CustomUser>> getContacts(String contactType) async {
    try {
      final response = await supabaseClient.from(contactType).select().eq('user_uuid', supabaseUser);
      final contacts = (response as List).map((e) => ContactModel.fromMap(e as Map<String, dynamic>)).toList();
      final List<CustomUser> users = [];
      for (var contact in contacts) {
        final response = await supabaseClient.from('users').select().eq('uuid', contact.contact_uuid).single();
        final user = CustomUser.fromMap(response);
        users.add(user);
      }
      return users;
    } catch (e) {
      print('Unable to get contacts: $e');
      throw Exception('Unable to get contacts: $e');
    }
  }

  Future<Map<String, dynamic>> getContactsData() async {
    try {
      final contacts = await getContacts("contacts");
      final followers = await getContacts("followers");
      final followings = await getContacts("followings");
      final contactsData = {'contacts': contacts, 'followers': followers, 'followings': followings};
      return contactsData;
    } catch (e) {
      print('Unable to get the contacts data: $e');
      throw Exception('Unable to get the contacts data: $e');
    }
  }

  Future<Map<String, dynamic>> getStoriesData() async {
    try {
      final publications = await getPublications("stories");
      final stories = await getPublicationItems("stories");
      final users = await getPublicationUsers("stories");
      final comments = await getComments("stories");
      final commentsUsers = await getCommentUsers("stories");
      final storiesData = {'publications': publications, 'stories': stories, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      return storiesData;
    } catch (e) {
      print('Unable to get the stories data: $e');
      throw Exception('Unable to get the stories data: $e');
    }
  }

  Future<Map<String, dynamic>> getPicsData() async {
    try {
      final publications = await getPublications("pics");
      final pics = await getPublicationItems("pics");
      final users = await getPublicationUsers("pics");
      final comments = await getComments("pics");
      final commentsUsers = await getCommentUsers("pics");
      final picsData = {'publications': publications, 'pics': pics, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      return picsData;
    } catch (e) {
      print('Unable to get the pics data: $e');
      throw Exception('Unable to get the pics data: $e');
    }
  }

  Future<Map<String, dynamic>> getPublicationsData() async {
    try {
      final publications = await getAllPublications();
      final publicationItems = await getAllPublicationItems();
      final users = await getAllPublicationUsers();
      final comments = await getAllComments();
      final commentsUsers = await getAllCommentUsers();
      final publicationData = {'publications': publications, 'publicationItems': publicationItems, 'users': users, 'comments': comments, 'commentsUsers': commentsUsers};
      print(publicationItems);
      return publicationData;
    } catch (e) {
      print('Unable to get the publication data: $e');
      throw Exception('Unable to get the publication data: $e');
    }
  }
}
