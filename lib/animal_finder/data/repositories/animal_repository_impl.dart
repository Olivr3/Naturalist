import 'package:dartz/dartz.dart';

import 'package:naturalista/animal_finder/data/datasources/animals_local_data_source.dart';
import 'package:naturalista/animal_finder/data/datasources/animals_remote_data_source.dart';
import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';
import 'package:naturalista/animal_finder/domain/repositories/animal_repository.dart';

import 'package:naturalista/core/connection/connection.dart';
import 'package:naturalista/core/error/exception.dart';
import 'package:naturalista/core/error/failure.dart';

class AnimalRepositoryImpl implements AnimalRepository {
  final AnimalsRemoteDataSource animalsRemoteDataSource;
  final AnimalsLocalDataSource animalsLocalDataSource;
  final Connection connection;

  AnimalRepositoryImpl(
      {required this.animalsRemoteDataSource,
      required this.animalsLocalDataSource,
      required this.connection});

  @override
  Future<Either<Failure, AnimalEntity>> getAnimals(String name) async {
    try {
      final isConnected = await connection.isConnected();
      final AnimalEntity animal;

      if (isConnected == false) {
        final cachedAnimal = await animalsLocalDataSource.getAnimals();

        // TODO: refactor logic
        if (cachedAnimal != null) {
          return Right(cachedAnimal as AnimalEntity);
        }
      }

      animal = await animalsRemoteDataSource.getAnimals(name);
      animalsLocalDataSource.saveAnimal(animal);

      return Right(animal);
    } on ServerException {
      return Left(ServerFailure(message: 'Server Failure'));
    }
  }
}
