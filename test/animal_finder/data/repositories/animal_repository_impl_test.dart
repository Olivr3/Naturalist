import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:naturalista/animal_finder/data/datasources/animals_local_data_source.dart';
import 'package:naturalista/animal_finder/data/datasources/animals_remote_data_source.dart';
import 'package:naturalista/animal_finder/data/models/animal_model.dart';
import 'package:naturalista/animal_finder/data/repositories/animal_repository_impl.dart';

import 'package:naturalista/animal_finder/domain/repositories/animal_repository.dart';

import 'package:naturalista/core/connection/connection.dart';

class AnimalsRemoteDataSourceMock extends Mock
    implements AnimalsRemoteDataSource {}

class AnimalsLocalDataSourceMock extends Mock
    implements AnimalsLocalDataSource {}

class ConnectionMock extends Mock implements Connection {}

void main() {
  group('AnimalRepositoryImpl', () {
    late AnimalRepository animalRepository;
    late AnimalsRemoteDataSource animalsRemoteDataSource;
    late AnimalsLocalDataSource animalsLocalDataSource;
    late Connection connection;

    setUp(() {
      animalsLocalDataSource = AnimalsLocalDataSourceMock();
      animalsRemoteDataSource = AnimalsRemoteDataSourceMock();
      connection = ConnectionMock();
      animalRepository = AnimalRepositoryImpl(
          animalsRemoteDataSource: animalsRemoteDataSource,
          animalsLocalDataSource: animalsLocalDataSource,
          connection: connection);
    });

    test('should return a animal from server', () async {
      AnimalModel animalModel = AnimalModel(name: 'Nico');

      AnimalModel animals = animalModel;

      when(() => connection.isConnected()).thenAnswer((_) async => true);

      when(() => animalsRemoteDataSource.getAnimals())
          .thenAnswer((_) async => animals);

      final result = await animalRepository.getAnimals();

      expect(result, Right(animals));

      verify(() => animalsRemoteDataSource.getAnimals()).called(1);
    });

    // failing test
    // test('should return a animal from cache', () async {
    //   final serverFailure = ServerFailure(message: 'Server Failure');

    //   when(() => connection.isConnected()).thenAnswer((_) async => true);

    //   when(() => animalsRemoteDataSource.getAnimals())
    //       .thenThrow(ServerException());

    //   final result = await animalRepository.getAnimals() as Failure;

    //   expect(result, Left(serverFailure));
    // });
  });
}
