import 'package:dartz/dartz.dart';

import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';
import 'package:naturalista/core/error/failure.dart';

abstract class AnimalRepository {
  Future<Either<Failure, AnimalEntity>> getAnimals(String name);
}
