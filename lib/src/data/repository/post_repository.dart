import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart';
import 'package:learning_flutter_animation/src/data/models/posts_model.dart';

class RequiredArguments {
  final SendPort sendPort;
  final int page;

  RequiredArguments(this.sendPort, this.page);
}

class PostRepository {
  fetchPosts(int page) async {
    try {
      final receivePort = ReceivePort();
      final isolate = await Isolate.spawn(
        _fetchPostIsolate,
        RequiredArguments(receivePort.sendPort, page),
      );
      final post = await receivePort.first;
      isolate.kill(priority: Isolate.immediate);
      return post;
    } catch (e) {
      throw Exception(e);
    }
  }

  _fetchPostIsolate(RequiredArguments args) async {
    final sendPort = args.sendPort;
    final String postRoute =
        'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=${args.page}';
    final response = await get(Uri.parse(postRoute));
    List<dynamic> jsonResponse = jsonDecode(response.body);
    final posts = jsonResponse.map((post) => PostModel.fromJson(post)).toList();
    sendPort.send(posts);
  }
}


// final response = await get(Uri.parse(postRoute));
// List<dynamic> jsonResponse = jsonDecode(response.body);
// final posts =
//     jsonResponse.map((post) => PostModel.fromJson(post)).toList();
// return posts;