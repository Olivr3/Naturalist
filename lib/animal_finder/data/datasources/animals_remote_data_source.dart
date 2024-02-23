import 'package:naturalista/animal_finder/data/models/animal_model.dart';

abstract class AnimalsRemoteDataSource {
  Future<AnimalModel> getAnimals(String animalName);
}
