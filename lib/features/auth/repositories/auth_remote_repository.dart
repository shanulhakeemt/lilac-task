import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:lilac_task/core/constants/server_constants.dart';
import 'package:lilac_task/core/failure/failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await http.post(Uri.parse("${ServerConstants.serverUrl}vendor-login"),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({"email": email, "password": password}));
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['message'].runtimeType == List
            ? (resBodyMap['message'] as List).first
            : resBodyMap['message']));
      }
      return Right(resBodyMap['token']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
