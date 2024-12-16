import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:lilac_task/core/constants/server_constants.dart';
import 'package:lilac_task/core/failure/failure.dart';
import 'package:lilac_task/core/models/vehicle_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
// ignore: deprecated_member_use_from_same_package
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, List<VehicleModel>>> getVehicles(
      String token) async {
    try {
      final response = await http.get(
        Uri.parse("${ServerConstants.serverUrl}vendor/get-total-vehicles"),
        headers: {'Authorization': 'Bearer $token'},
      );

      final resBodyMap = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['message'].runtimeType == List
            ? (resBodyMap['message'] as List).first
            : resBodyMap['message']));
      }
      final vehicles = (resBodyMap['data'] as List)
          .map(
            (e) => VehicleModel.fromMap(e),
          )
          .toList();
      return Right(vehicles);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, String>> addRequirement(
      {required String vehicleTypeId,
      required String brandId,
      required String vehicleModelId,
      required String vehicleVarienteId,
      required String transmissionId,
      required String fuelTypeId,
      required String vehicleColorId,
      required String year,
      required String token}) async {
    try {
      final reqMap = jsonEncode({
        'vehicle_type_id': vehicleTypeId,
        'brand_id': brandId,
        'vehicle_model_id': vehicleModelId,
        'vehicle_variant_id': vehicleVarienteId,
        'transmission_id': transmissionId,
        'fuel_type_id': fuelTypeId,
        'vehicle_color_id': vehicleColorId,
        'year': year
      });
      final response = await http.post(
          Uri.parse("${ServerConstants.serverUrl}add-requirement"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: reqMap);
      print(response.body);
      final resBodyMap = jsonDecode(response.body);
      print(resBodyMap);
      if (resBodyMap['status'] != true) {
        return Left(AppFailure(resBodyMap['message']));
      } else {
        return Right('Vehicle requirement created');
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
