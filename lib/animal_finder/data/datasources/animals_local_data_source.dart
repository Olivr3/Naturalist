import 'package:dartz/dartz.dart';

import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';

abstract class AnimalsLocalDataSource {
  Future<Either<Null, AnimalEntity>> getAnimals();
  void saveAnimal(AnimalEntity animalModel);
}
