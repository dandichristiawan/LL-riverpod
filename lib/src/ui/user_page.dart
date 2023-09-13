import 'package:flutter/material.dart';
import 'package:riverpod_1/src/providers/single_user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: userData.when(
        data: (userData) {
          final user = userData;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Image.network(
                      '${user?.avatar}',
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text('${user?.firstName} ${user?.lastName}'),
                Text('${user?.email}'),
              ],
            ),
          );
        },
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
