import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/stream_provider.dart';

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: const StreamView(),
    );
  }
}

// manera de hacer 1
// class StreamView extends ConsumerWidget {
//   const StreamView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final usersInChatAsync = ref.watch(userInChatProvider);

//     if (usersInChatAsync.hasError) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     if (usersInChatAsync.isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     final users = usersInChatAsync.value!;

//     return ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (BuildContext context, int index) {
//         final user = users[index];
//         return ListTile(
//           title: Text(user),
//         );
//       },
//     );
//   }
// }

// manera de hacer 2
class StreamView extends ConsumerWidget {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersInChatAsync = ref.watch(userInChatProvider);

    return usersInChatAsync.when(
      data: (users) {
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];
            return ListTile(
              title: Text(user),
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
