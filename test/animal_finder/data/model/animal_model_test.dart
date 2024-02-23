import 'package:flutter_test/flutter_test.dart';

import 'package:naturalista/animal_finder/data/models/animal_model.dart';

void main() {
  group('AnimalModel', () {
    test('fromJson should return an AnimalModel instance', () {
      // Arrange
      final json = {'name': 'Lion'};

      // Act
      final animal = AnimalModel.fromJson(json);

      // Assert
      expect(animal, isA<AnimalModel>());
      expect(animal.name, 'Lion');
    });
  });
}
