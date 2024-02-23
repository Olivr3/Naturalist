import 'package:flutter/material.dart';

import 'package:naturalista/animal_finder/presenter/widgets/AnimalList.dart';
import 'package:naturalista/animal_finder/presenter/widgets/searchBar.dart';

class AnimalsPage extends StatelessWidget {
  const AnimalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          MainSearchBar(),
          const SizedBox(height: 20),
          AnimalList(),
        ],
      ),
    );
  }
}
