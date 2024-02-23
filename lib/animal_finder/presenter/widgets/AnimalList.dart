import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:naturalista/animal_finder/presenter/providers/animals_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnimalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void clearResults() {
      Provider.of<AnimalsProvider>(context, listen: false).clearAnimals();
    }

    return Consumer<AnimalsProvider>(
      builder: (context, cart, child) {
        return Column(
          children: [
            Skeletonizer(
              enabled: cart.isLoading,
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  children: cart.animalsEntity
                      .map((animal) => Card(
                            child: Wrap(
                              children: [
                                Image.asset('images/placeholder.png'),
                                ListTile(
                                  title: Text(animal.name),
                                  subtitle: Text(animal.taxonomy['family']),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            if (cart.animalsEntity.isNotEmpty)
              ElevatedButton(
                onPressed: clearResults,
                child: Text('Clear results'),
              )
          ],
        );
      },
    );
  }
}
