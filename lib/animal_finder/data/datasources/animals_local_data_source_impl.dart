import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:naturalista/animal_finder/data/models/animal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:naturalista/animal_finder/data/datasources/animals_local_data_source.dart';
import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';

class AnimalsLocalDataSourceImpl implements AnimalsLocalDataSource {
  @override
  Future<Either<Null, AnimalEntity>> getAnimals() async {
    final prefs = await SharedPreferences.getInstance();

    final result = await prefs.getString('animals');

    if (result != null) {
      final animalJSON = jsonDecode(result);
      final animal = AnimalModel(
        name: animalJSON['name'],
        taxonomy: jsonDecode(animalJSON['taxonomy']),
      );
      return Right(animal);
    }

    return Left(null);
  }

  void saveAnimal(AnimalEntity animal) async {
    final prefs = await SharedPreferences.getInstance();
    final animalModel =
        AnimalModel(name: animal.name, taxonomy: animal.taxonomy);
    final animalsStringfy = animalModel.toJson();

    await prefs.setString('animals', jsonEncode(animalsStringfy));
  }
}
