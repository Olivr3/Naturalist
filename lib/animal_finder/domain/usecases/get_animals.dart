import 'package:dartz/dartz.dart';

import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';
import 'package:naturalista/animal_finder/domain/repositories/animal_repository.dart';

import 'package:naturalista/core/error/failure.dart';
import 'package:naturalista/core/usecases/usecases.dart';

class GetAnimals implements UseCase<AnimalEntity, String> {
  final AnimalRepository repository;

  const GetAnimals(this.repository);

  @override
  Future<Either<Failure, AnimalEntity>> call(String name) async {
    return await repository.getAnimals(name);
  }
}
