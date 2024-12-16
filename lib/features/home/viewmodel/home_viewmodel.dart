import 'package:fpdart/fpdart.dart';
import 'package:lilac_task/core/providers/current_token_provider.dart';
import 'package:lilac_task/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepository _homeRepository;

  addRequirement({
    required String vehicleTypeId,
      required String brandId,
      required String vehicleModelId,
      required String vehicleVarienteId,
      required String transmissionId,
      required String fuelTypeId,
      required String vehicleColorId,
      required String year,
  }) async {
    state = const AsyncLoading();
    final res =
        await _homeRepository.addRequirement(
          brandId: brandId,
          fuelTypeId: fuelTypeId,
          token: ref.watch(currentTokenProvider),
          transmissionId: transmissionId,
          vehicleColorId: vehicleColorId, 
          vehicleModelId: vehicleModelId, 
          vehicleTypeId: vehicleTypeId, 
          vehicleVarienteId: vehicleVarienteId,
          year: year
          );
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
