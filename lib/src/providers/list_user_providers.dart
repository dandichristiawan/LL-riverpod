import 'package:flutter/material.dart';
import 'package:riverpod_1/src/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_1/src/repository/user_repository.dart';

import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

final userListRepositoryProvider = Provider<UserListRepository>(
  (ref) => UserListRepository(),
);

final scrollControllerProvider = Provider<ScrollController>(
  (ref) {
    final controller = ScrollController();

    controller.addListener(
      () {
        if (controller.position.atEdge && controller.position.pixels > 0) {
          ref.watch(pageProvider.notifier).state += 1;
          logger.i('pageProvider state: $pageProvider');
        }
      },
    );
    return controller;
  },
);

final pageProvider = StateProvider<int>(
  (ref) {
    return 1;
  },
);

final userListProvider = FutureProvider.autoDispose<List<Data>>(
  (ref) async {
    final userListRepository = ref.watch(userListRepositoryProvider);
    final page = ref.watch(pageProvider.notifier).state;
    try {
      final userList = await userListRepository.getListUser(page);
      return userList;
    } catch (e) {
      throw Exception(e);
    }
  },
);
