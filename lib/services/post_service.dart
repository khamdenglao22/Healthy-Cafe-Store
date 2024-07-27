import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app/models/post_model.dart';
import 'dart:developer';

import 'package:store_app/services/base_service.dart';

class PostService extends BaseService {
  Future<List<PostModel>> fetchPost() async {
    try {
      var resopnes = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (resopnes.statusCode == 200) {
        var data = resopnes.body;
        return postModelFromJson(data);
      }
      return [];
    } catch (e) {
      log('Error == $e');
    }
    return [];
  }
}
