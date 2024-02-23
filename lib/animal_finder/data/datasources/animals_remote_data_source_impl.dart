import 'dart:convert';

import 'package:naturalista/animal_finder/data/datasources/animals_remote_data_source.dart';
import 'package:naturalista/animal_finder/data/models/animal_model.dart';

import 'package:naturalista/core/http_client/http_client.dart';
import 'package:naturalista/secrets/api_keys.dart';

class AnimalsRemoteDataSourceImpl extends AnimalsRemoteDataSource {
  final HttpClient httpClient;

  AnimalsRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<AnimalModel> getAnimals(String animalName) async {
    final response = await httpClient.get(
        'https://api.api-ninjas.com/v1/animals?name=$animalName',
        {'x-api-key': ANIMALS_API_KEY});

    if (response.statusCode == 200) {
      final jsonArray = jsonDecode(response.data);

      return AnimalModel.fromJson(jsonArray[0]);
    } else {
      throw Exception();
    }
  }
}
