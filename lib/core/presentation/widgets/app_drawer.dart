//

import 'package:flutter/material.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: context.colorScheme.primaryContainer,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFFDEBF9),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                context.translate.drawer_header,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  // fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.grey.shade50,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          onTap: () {
                            context.navigator.pop();
                            context.navigator.pushNamed(AppScreens.history);
                          },
                          leading: const Icon(Icons.history),
                          title: Text(
                            context.translate.history,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              // fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      context.navigator.pop();
                      context.navigator.pushNamed(AppScreens.allEntries);
                    },
                    leading: const Icon(Icons.settings),
                    title: Text(
                      'TEST',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        // fontSize: 22,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      context.navigator.pop();
                      context.navigator.pushNamed(AppScreens.settings);
                    },
                    leading: const Icon(Icons.settings),
                    title: Text(
                      context.translate.settings,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        // fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
