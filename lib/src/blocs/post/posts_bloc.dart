import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter_animation/src/data/models/posts_model.dart';
import 'package:learning_flutter_animation/src/data/repository/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;

  // Define Initial Page
  int page = 1;

  // Declare Loading bool variable to
  // show Loading indicator when fetching new posts
  bool isLoadMore = false;

  // Scroll Controller for ListView Builder
  ScrollController scrollController = ScrollController();

  PostsBloc(this._postRepository) : super(const PostsInitial(null)) {
    // ---------------------------------------------
    // Add a listener to Controller
    // and Load more posts when scrolled till last
    // ---------------------------------------------
    scrollController.addListener(() {
      add(PostsLoadMoreEvent());
    });

    // ---------------------------------------------
    // Posts Load Event
    // ---------------------------------------------
    on<PostsLoadedEvent>((event, emit) async {
      emit(const PostsInitial(null));
      try {
        final posts = await _postRepository.fetchPosts(page);
        emit(PostsLoadedState(posts: posts));
      } catch (error) {
        emit(PostsErrorState(error.toString()));
      }
    });

    // ---------------------------------------------
    // Posts LoadMore Event
    // ---------------------------------------------
    on<PostsLoadMoreEvent>((event, emit) async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadMore = true;
        page++;
        final newPosts = await _postRepository.fetchPosts(page);

        // ---------------------------------------------
        // Appending/Combining Load List with new list
        // ---------------------------------------------
        emit(PostsLoadedState(
          posts: [...state.posts, ...newPosts],
        ));
      }
    });
  }
}
