import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:naturalista/animal_finder/presenter/providers/animals_provider.dart';

class MainSearchBar extends StatefulWidget {
  @override
  State<MainSearchBar> createState() => _MainSearchBarState();
}

class _MainSearchBarState extends State<MainSearchBar> {
  String value = '';

  void changeValue(String value) {
    setState(() {
      value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        onSubmitted: (value) {
          Provider.of<AnimalsProvider>(context, listen: false)
              .getAnimals(value);

          changeValue('');
        },
        onChanged: changeValue,
        decoration: InputDecoration(
          hintText: 'Search for animals',
          suffixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
