import 'package:fpdart/fpdart.dart';
import 'package:lilac_task/core/providers/current_token_provider.dart';
import 'package:lilac_task/features/auth/repositories/auth_local_repository.dart';
import 'package:lilac_task/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res =
        await _authRemoteRepository.login(email: email, password: password);

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => updateCurrentToken(r),
    };
  }

  updateCurrentToken(String token) {
    print(token);
    _authLocalRepository.setToken(token);
    ref.read(currentTokenProvider.notifier).update(
          (state) => token,
        );
    state = AsyncValue.data(token);
  }

  String? getToken() {
    final token = _authLocalRepository.getToken();
    if (token != null) {
      ref.read(currentTokenProvider.notifier).update(
            (state) => token,
          );
    }

    return token;
  }

  @override
  AsyncValue<String>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }
}
