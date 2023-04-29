import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter_animation/src/blocs/counter/counter_bloc.dart';
import 'package:learning_flutter_animation/src/blocs/post/posts_bloc.dart';
import 'package:learning_flutter_animation/src/data/models/posts_model.dart';
import 'package:learning_flutter_animation/src/data/repository/post_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: RepositoryProvider(
        create: (context) => PostRepository(),
        child: BlocProvider(
          create: (context) => PostsBloc(context.read<PostRepository>())
            ..add(PostsLoadedEvent()),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsInitial) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (state is PostsLoadedState) {
                final List<PostModel> posts = state.posts;
                return ListView.builder(
                  controller: context.read<PostsBloc>().scrollController,
                  itemCount: context.read<PostsBloc>().isLoadMore
                      ? posts.length + 1
                      : posts.length,
                  itemBuilder: (context, index) {
                    if (index >= posts.length) {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      final post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(
                          bottom: 0,
                        ),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(post.id.toString()),
                            ),
                            title: Text(post.title),
                            subtitle: Text(post.body),
                          ),
                        ),
                      );
                    }
                  },
                );
              }
              if (state is PostsErrorState) {
                return Center(
                  child: SelectableText(state.error),
                );
              } else {
                return const Center(child: Text("No Posts"));
              }
            },
          ),
        ),
      ),
    );
  }

  BlocProvider<CounterBloc> counterBlocProvider() {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state is CounterInitialState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Incremet"),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Counter Value: ${state.counter}'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text("Decrement Value"),
                    onPressed: () => BlocProvider.of<CounterBloc>(context).add(
                      CounterDecrementEvent(),
                    ),
                  ),
                  TextButton(
                    child: const Text("Increment Value"),
                    onPressed: () => BlocProvider.of<CounterBloc>(context).add(
                      CounterIncrementEvent(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
