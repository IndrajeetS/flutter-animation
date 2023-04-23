part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

// Bloc Event to LoadPosts
class PostsLoadedEvent extends PostsEvent {}

// Bloc Event to LoadMorePosts
class PostsLoadMoreEvent extends PostsEvent {}
