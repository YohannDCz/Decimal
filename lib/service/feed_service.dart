import 'package:decimal/config/constants.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';

class FeedService {
  Future<List<PublicationModel>> getPublications(String publication) async {
    try {
      final response = await supabaseClient.from("publications").select().eq('type', publication).limit(18).order('date_of_publication', ascending: false);
      final publicationModel = (response as List).map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      print('$publication: $publicationModel');
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

  Future<List<CustomUser>> getUsers() async {
    try {
      final response = await supabaseClient.from("users").select();
      final users = (response as List).map((e) => CustomUser.fromMap(e as Map<String, dynamic>)).toList();
      print('Users: $users');
      return users;
    } catch (e) {
      print('Unable to get users: $e');
      throw Exception('Unable to get users: $e');
    }
  }

  Future<List<CustomUser>> getPublicationUsers(String publicationType) async {
    try {
      // Obtention des publications filtrées par le type spécifié.
      final response = await supabaseClient.from('publications').select('users(*)').eq('type', publicationType).order('date_of_publication', ascending: false);
      List<CustomUser> publicationUsers = (response as List).map((e) => CustomUser.fromMap(e["users"] as Map<String, dynamic>)).toList();
      return publicationUsers;
    } catch (e) {
      print('Erreur lors de la récupération des utilisateurs ou des publications : $e');
      throw Exception('Erreur lors de la récupération des utilisateurs ou des publications : $e');
    }
  }

  String getDuration(DateTime time) {
    final duration = DateTime(2029).difference(time);
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
