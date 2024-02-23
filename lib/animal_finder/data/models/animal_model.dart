import 'dart:convert';

import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';

class AnimalModel extends AnimalEntity {
  AnimalModel({required String name, required Map<String, dynamic> taxonomy})
      : super(name: name, taxonomy: taxonomy);

  factory AnimalModel.fromJson(Map<String, dynamic> json) =>
      AnimalModel(name: json['name'], taxonomy: json['taxonomy']);

  Map<String, dynamic> toJson() => {
        'name': name.toString(),
        'taxonomy': jsonEncode(taxonomy),
      };
}
