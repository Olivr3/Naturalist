import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:naturalista/core/providers/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void setTheme() {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.toggleThemeData();
    }

    final Widget icon = Provider.of<ThemeProvider>(context).isDarkMode
        ? const Icon(Icons.dark_mode)
        : const Icon(Icons.dark_mode_outlined);

    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () {
            setTheme();
          },
        ),
      ],
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
