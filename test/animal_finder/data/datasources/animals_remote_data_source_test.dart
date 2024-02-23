import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:naturalista/animal_finder/data/datasources/animals_remote_data_source.dart';
import 'package:naturalista/animal_finder/data/datasources/animals_remote_data_source_impl.dart';
import 'package:naturalista/animal_finder/data/models/animal_model.dart';
import 'package:naturalista/core/error/exception.dart';
import 'package:naturalista/core/http_client/http_client.dart';
import 'package:naturalista/secrets/api_keys.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  const animalName = 'cheetah';
  const url = 'https://api.api-ninjas.com/v1/animals?name=$animalName';
  const headers = {'x-api-key': ANIMALS_API_KEY};

  final AnimalModel animalModel =
      AnimalModel(name: "Cheetah", taxonomy: {"kingdom": "Animalia"});

  const animal = """ {
        "name": "Cheetah",
        "taxonomy": {
          "kingdom": "Animalia",
          "phylum": "Chordata",
          "class": "Mammalia",
          "order": "Carnivora",
          "family": "Felidae",
          "genus": "Acinonyx",
          "scientific_name": "Acinonyx jubatus"
        },
        "locations": ["Africa", "Asia", "Eurasia"],
        "characteristics": {
          "prey": "Gazelle, Wildebeest, Hare",
          "name_of_young": "Cub",
          "group_behavior": "Solitary/Pairs",
          "estimated_population_size": "8,500",
          "biggest_threat": "Habitat loss",
          "most_distinctive_feature":
              "Yellowish fur covered in small black spots",
          "gestation_period": "90 days",
          "habitat": "Open grassland",
          "diet": "Carnivore",
          "average_litter_size": "3",
          "lifestyle": "Diurnal",
          "common_name": "Cheetah",
          "number_of_species": "5",
          "location": "Asia and Africa",
          "slogan": "The fastest land mammal in the world!",
          "group": "Mammal",
          "color": "BrownYellowBlackTan",
          "skin_type": "Fur",
          "top_speed": "70 mph",
          "lifespan": "10 - 12 years",
          "weight": "40kg - 65kg (88lbs - 140lbs)",
          "height": "115cm - 136cm (45in - 53in)",
          "age_of_sexual_maturity": "20 - 24 months",
          "age_of_weaning": "3 months"
        }
      } """;

  group('AnimalsRemoteDataSource', () {
    late AnimalsRemoteDataSource animalsRemoteDataSource;
    late HttpClient httpClient;

    setUp(() {
      httpClient = HttpClientMock();
      animalsRemoteDataSource =
          AnimalsRemoteDataSourceImpl(httpClient: httpClient);
    });

    test('should call get method with the correct params', () async {
      when(() => httpClient.get(any(), any()))
          .thenAnswer((_) async => HttpResponse(
                data: animal,
                statusCode: 200,
              ));

      await animalsRemoteDataSource.getAnimals(animalName);

      verify(() => httpClient.get(url, headers)).called(1);
    });

    test(
        'should return the AnimalModel when is successful',
        () => () async {
              when(() => httpClient.get(any(), any()))
                  .thenAnswer((_) async => HttpResponse(
                        data: animalModel,
                        statusCode: 200,
                      ));

              final result =
                  await animalsRemoteDataSource.getAnimals(animalName);

              expect(result, isA<AnimalModel>());
              expect(result, animalModel);
            });

    test(
        'should throw a ServerException when the call is unsuccessful',
        () => () async {
              when(() => httpClient.get(any(), any()))
                  .thenAnswer((_) async => throw Exception());

              final call = animalsRemoteDataSource.getAnimals;

              expect(call, ServerException());
            });
  });
}
