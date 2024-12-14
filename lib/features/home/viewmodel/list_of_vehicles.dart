
import 'package:lilac_task/core/models/vehicle_model.dart';
import 'package:lilac_task/core/providers/current_token_provider.dart';
import 'package:lilac_task/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final listOfVehiclesViewModelProvider =
    AsyncNotifierProvider<ListOfVehiclesViewModel, List<VehicleModel>>(
  () => ListOfVehiclesViewModel(),
);

class ListOfVehiclesViewModel extends AsyncNotifier<List<VehicleModel>> {
  late HomeRepository _homeRepository;

  Future<void> getVehicles() async {
    state = const AsyncLoading();

    await Future.delayed(const Duration(milliseconds: 1000));
    final res =
        await _homeRepository.getVehicles(ref.watch(currentTokenProvider));
    res.fold(
      (l) {
        state = AsyncError(l.message, StackTrace.current);
      },
      (r) async {
        state = await AsyncValue.guard(
          () => Future.value(r),
        );
      },
    );
  }

  @override
  FutureOr<List<VehicleModel>> build() async {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return [];
  }
}
