import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:house_app/configuration/routing/app_router.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:house_app/dependancy_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      create: (context) => di.locator(),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        buildWhen: (previous, current) => previous.appLang != current.appLang,
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily:
                  state.appLang.languageCode == 'en' ? "Poppins" : "Cairo",
            ),
            locale: state.appLang,
            onGenerateRoute: AppRouter.generate,
            initialRoute: AppScreens.initial,
          );
        },
      ),
    );
  }
}
