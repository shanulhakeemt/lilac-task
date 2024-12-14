// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleModel {
  final int id;
  // ignore: non_constant_identifier_names
  final String unique_id;
  final String price;
  // ignore: non_constant_identifier_names
  final String vehicle_status;
  final String year;
  VehicleModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.unique_id,
    required this.price,
    // ignore: non_constant_identifier_names
    required this.vehicle_status,
    required this.year,
  });


  VehicleModel copyWith({
    int? id,
    // ignore: non_constant_identifier_names
    String? unique_id,
    String? price,
    // ignore: non_constant_identifier_names
    String? vehicle_status,
    String? year,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      unique_id: unique_id ?? this.unique_id,
      price: price ?? this.price,
      vehicle_status: vehicle_status ?? this.vehicle_status,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'unique_id': unique_id,
      'price': price,
      'vehicle_status': vehicle_status,
      'year': year,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['id'] ??0,
      unique_id: map['unique_id'] ??'',
      price: map['price'] ??'',
      vehicle_status: map['vehicle_status'] ??'',
      year: map['year'] ??'',
    );
  }
}
