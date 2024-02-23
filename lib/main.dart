import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:naturalista/core/providers/theme.dart';
import 'package:naturalista/core/theme/theme.dart';
import 'package:naturalista/animal_finder/presenter/pages/plants_page.dart';
import 'package:naturalista/animal_finder/presenter/pages/animals_page.dart';
import 'package:naturalista/animal_finder/presenter/widgets/appBar.dart';
import 'package:naturalista/animal_finder/presenter/providers/animals_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AnimalsProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp(
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: NaturalistApp());
  }
}

class NaturalistApp extends StatefulWidget {
  const NaturalistApp({
    super.key,
  });

  @override
  State<NaturalistApp> createState() => _NaturalistAppState();
}

class _NaturalistAppState extends State<NaturalistApp> {
  final List<Widget> _pages = [AnimalsPage(), PlantsPage()];
  int activePageIndex = 0;

  void setActivePageIndex(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Naturalist'),
      body: _pages[activePageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: activePageIndex,
          onTap: (index) {
            setActivePageIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Animals',
              icon: Icon(Icons.pets),
            ),
            BottomNavigationBarItem(
              label: 'Plants',
              icon: Icon(Icons.grass),
            ),
          ],
        ),
      ),
    );
  }
}
