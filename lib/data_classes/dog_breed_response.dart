import 'package:equatable/equatable.dart';
import 'package:flutter_architectural_flow/core/constants.dart';

class DogBreedListResponse extends Equatable {
  List<DogBreed>? dogBreedList;
  DogBreedListResponse({
    this.dogBreedList = const []
  });

  factory DogBreedListResponse.fromJson(Map<String, dynamic> json) {
    final dogBreedList = <DogBreed>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dogBreedList.add(DogBreed.fromJson(v));
      });
    }
    return DogBreedListResponse(
        dogBreedList: dogBreedList
    );
  }

  @override
  List<Object?> get props => [dogBreedList];
}

class DogBreed extends Equatable{
  DogBreedAttributes? dogBreedAttrs;
  DogBreed({
    this.dogBreedAttrs = const DogBreedAttributes()
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
        dogBreedAttrs: DogBreedAttributes.fromJson(json["attributes"])
    );
  }

  @override
  List<Object?> get props => [dogBreedAttrs];
}

class DogBreedAttributes extends Equatable {
  final String? name;
  final String? description;

  const DogBreedAttributes({
    this.name = strConstant,
    this.description = strConstant
  });

  factory DogBreedAttributes.fromJson(Map<String, dynamic> json) {
    return DogBreedAttributes(
        name: json["name"] ?? strConstant,
        description: json["description"] ?? strConstant
    );
  }

  @override
  List<Object?> get props => [name, description];
}