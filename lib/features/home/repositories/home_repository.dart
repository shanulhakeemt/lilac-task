import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:lilac_task/core/constants/server_constants.dart';
import 'package:lilac_task/core/failure/failure.dart';
import 'package:lilac_task/core/models/vehicle_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, List<VehicleModel>>> getVehicles(
      String token) async {
    try {
      print('token $token');
      final response = await http.get(
        Uri.parse("${ServerConstants.serverUrl}vendor/get-total-vehicles"),
        headers: {
          // 'Content-Type': 'application/json',
          'Authorization': token
        },

        



      );

      final resBodyMap = jsonDecode(response.body);
      print(resBodyMap);
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
      print(vehicles);
      return Right(vehicles);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, String>> addRequirement(String token) async {
    try {
      final response = await http.post(
          Uri.parse("${ServerConstants.serverUrl}add-requirement"),
          headers: {
            // 'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: {
            'vehicle_type_id': 1,
            'brand_id': 1,
            'vehicle_model_id': 1,
            'vehicle_variant_id': 1,
            'transmission_id': 1,
            'fuel_type_id': 1,
            'vehicle_color_id': 1,
            'year': 2024
          });
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
