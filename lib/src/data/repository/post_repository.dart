import 'dart:convert';

import 'package:http/http.dart';
import 'package:learning_flutter_animation/src/data/models/posts_model.dart';

class PostRepository {
  Future<List<PostModel>> fetchPosts(int page) async {
    final String postRoute =
        'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=$page';

    try {
      final response = await get(Uri.parse(postRoute));
      List<dynamic> jsonResponse = jsonDecode(response.body);
      final posts =
          jsonResponse.map((post) => PostModel.fromJson(post)).toList();
      return posts;
    } catch (e) {
      throw Exception(e);
    }
  }
}
