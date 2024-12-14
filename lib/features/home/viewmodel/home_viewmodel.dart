import 'package:fpdart/fpdart.dart';
import 'package:lilac_task/core/providers/current_token_provider.dart';
import 'package:lilac_task/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepository _homeRepository;

  addRequirement() async {
    state = const AsyncLoading();
    final res =
        await _homeRepository.addRequirement(ref.watch(currentTokenProvider));
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncData(r),
    };
  }

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }
}
