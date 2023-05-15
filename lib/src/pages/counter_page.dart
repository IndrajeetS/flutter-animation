import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((ref) => 0);

class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watching the counterProvider
    final counter = ref.watch(counterProvider);
    // Listening the counterProvider and doing something
    ref.listen(
      counterProvider,
      (previous, next) {
        log("$previous and $next");
        if (next == 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("I just reached 5"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
    return Scaffold(
      body: Center(
        child: Text(
          counter.toString(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ref.read(counterProvider.notifier).state += 1;
        },
      ),
    );
  }
}
