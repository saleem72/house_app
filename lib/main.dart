import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:house_app/configuration/routing/app_router.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:house_app/dependency_injection.dart' as di;
import 'package:house_app/features/home_screen/data/repository/home_repository.dart';
import 'package:house_app/features/home_screen/presentation/statistic_bloc/statistic_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleBloc>(
          create: (context) => di.locator(),
        ),
        BlocProvider(
          create: (context) =>
              StatisticBloc(repository: HomeRepository(db: di.locator()))
                ..add(HomeSubscribeEvent()),
        ),
      ],
      child: _buildApp(),
    );
  }

  BlocBuilder<LocaleBloc, LocaleState> _buildApp() {
    return BlocBuilder<LocaleBloc, LocaleState>(
      buildWhen: (previous, current) => previous.appLang != current.appLang,
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
              // primary: Colors.deepPurple,
              secondary: const Color(0xFFFDEBF9),
            ),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFFDEBF9),
              foregroundColor: Colors.black,
            ),
            fontFamily:
                state.appLang.languageCode == 'en' ? "Poppins" : "Cairo",
          ),
          locale: state.appLang,
          onGenerateRoute: AppRouter.generate,
          initialRoute: AppScreens.initial,
        );
      },
    );
  }
}
