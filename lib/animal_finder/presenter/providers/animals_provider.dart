import 'package:flutter/material.dart';

import 'package:naturalista/animal_finder/data/datasources/animals_local_data_source_impl.dart';
import 'package:naturalista/animal_finder/data/datasources/animals_remote_data_source_impl.dart';
import 'package:naturalista/animal_finder/data/repositories/animal_repository_impl.dart';
import 'package:naturalista/animal_finder/domain/entities/animal_entity.dart';

import 'package:naturalista/core/connection/connection.dart';
import 'package:naturalista/core/http_client/http_impl.dart';

class AnimalsProvider extends ChangeNotifier {
  List<AnimalEntity> _animalsEntity = [];
  bool _isLoading = false;

  List<AnimalEntity> get animalsEntity => _animalsEntity;
  bool get isLoading => _isLoading;

  void clearAnimals() {
    _animalsEntity = [];
    notifyListeners();
  }

  void getAnimals(String name) async {
    _isLoading = true;
    notifyListeners();

    final animalRep = AnimalRepositoryImpl(
        animalsRemoteDataSource:
            AnimalsRemoteDataSourceImpl(httpClient: HttpClientImpl()),
        animalsLocalDataSource: AnimalsLocalDataSourceImpl(),
        connection: ConnectionImpl());

    final result = await animalRep.getAnimals(name);

    result.fold((l) {}, (r) {
      _animalsEntity = [r];
    });
    _isLoading = false;
    notifyListeners();
  }
}
