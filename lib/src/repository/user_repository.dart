import 'package:dio/dio.dart';
import 'package:riverpod_1/src/model/user_model.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);
final Dio _dio = Dio();
const url = 'https://reqres.in/api/users';
const urlPagination = 'https://reqres.in/api/users/?page=1';

class UserRepository {
  Future<Data?> getUser(String id) async {
    try {
      final response = await _dio.get('$url/$id');
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.i(response.data);
        return Data.fromJson(json['data']);
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class UserListRepository {
  Future<List<Data>> getListUser(int page) async {
    try {
      final response = await _dio.get('$urlPagination/$page');
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data as Map<String, dynamic>;
        final userList = json['data'] as List<dynamic>;
        logger.i(userList);
        final List<Data> users = userList.map((userData) {
          return Data.fromJson(userData as Map<String, dynamic>);
        }).toList();
        return users;
      } else {
        throw Exception('F');
      }
    } catch (e) {
      throw Exception('D');
    }
  }
}
