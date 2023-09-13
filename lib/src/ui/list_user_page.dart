import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_1/src/providers/list_user_providers.dart';

class ListUser extends ConsumerStatefulWidget {
  const ListUser({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListUserState();
}

class _ListUserState extends ConsumerState<ListUser> {
  @override
  Widget build(BuildContext context) {
    final userListData = ref.watch(userListProvider);
    final scroll = ref.watch(scrollControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: userListData.when(
        data: (userListData) {
          final userList = userListData;
          return ListView.builder(
            controller: scroll,
            itemExtent: 135,
            itemBuilder: (context, index) {
              if (index < userList.length) {
                final user = userList[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(5.0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: ClipOval(
                      child: Image.network('${user.avatar}'),
                    ),
                  ),
                  title: Text('${user.firstName!} ${user.lastName}'),
                  subtitle: Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Quasi, sunt.',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  trailing: Text(
                    user.id.toString(),
                  ),
                  isThreeLine: true,
                );
              }
              return null;
            },
            itemCount: userListData.length,
            shrinkWrap: true,
          );
        },
        error: (error, stack) => Center(
          child: Text('$error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
