import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';
import 'package:naturalista/animal_finder/domain/usecases/get_animals.dart';
import 'package:naturalista/animal_finder/domain/repositories/animal_repository.dart';

import 'package:naturalista/core/entities/params.dart';
import 'package:naturalista/core/error/failure.dart';

class MockAnimalRepository extends Mock implements AnimalRepository {}

void main() {
  late GetAnimals usecase;
  late Failure failure;
  late AnimalRepository repository;

  group('get_animals', () {
    setUp(() {
      repository = MockAnimalRepository();
      failure = Failure(message: 'Server Failure');
      usecase = GetAnimals(repository);
    });

    test('should get a list of animals from the repository', () async {
      final noParams = NoParams();
      final nico = AnimalEntity(name: 'Nico');
      final animals = nico;

      when(() => repository.getAnimals())
          .thenAnswer((_) async => Right(animals));

      final result = await usecase(noParams);

      expect(result, Right(animals));

      verify(() => repository.getAnimals()).called(1);
    });

    test('should return a server failure', () async {
      final noParams = NoParams();

      when(() => repository.getAnimals())
          .thenAnswer((_) async => Left(failure));

      final result = await usecase(noParams);

      expect(result, Left(failure));
    });
  });
}
