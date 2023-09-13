import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_1/src/model/user_model.dart';
import 'package:riverpod_1/src/repository/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(),
);

final idControllerProvider = Provider<TextEditingController>(
  (ref) {
    return TextEditingController();
  },
);

final userIdProvider = Provider.autoDispose<String>(
  (ref) {
    final idController = ref.watch(idControllerProvider);
    final text = idController.text;
    return text;
  },
);
final userProvider = FutureProvider.autoDispose<Data?>(
  (ref) async {
    final userRepository = ref.watch(userRepositoryProvider);
    final id = ref.watch(userIdProvider);
    try {
      final user = await userRepository.getUser(id);
      return user;
    } catch (e) {
      throw Exception('$e');
    }
  },
);
