// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';

import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/dependancy_injection.dart';
import 'package:house_app/features/home_screen/data/repository/home_repository.dart';
// import 'package:intl/intl.dart';

import 'domian/models/button_category.dart';
import 'presentation/home_bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(repository: HomeRepository(db: locator()))
        ..add(HomeSubscribeEvent()),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDEBF9),
        title: Text(
          context.translate.home,
          style: context.textTheme.titleLarge?.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => context.navigator.pushNamed(AppScreens.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/image2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return switch (state) {
                HomeInitial() => _content(context, state.expenses),
                HomeLoading() =>
                  const Center(child: CircularProgressIndicator()),
                HomeSuccess() => _content(context, state.expenses)
              };
            },
          )
        ],
      ),
    );
  }

  Column _content(BuildContext context, List<ExpenseCategory> expenses) {
    var size = context.mediaQuery.size;

    /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double widgetWidth = size.width;
    final double gridWidth = widgetWidth - 8;
    const double ratio = 0.75;
    // final double
    return Column(
      children: [
        const SizedBox(height: 32),
        AspectRatio(
          aspectRatio: widgetWidth / widgetWidth * ratio * 2,
          child: GridView.builder(
            // padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: (gridWidth * ratio) / (gridWidth / 2),
            ),
            itemCount: expenses.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == expenses.length) {
                return MainButton(
                  expense: null,
                  isHistory: true,
                  onTap: () =>
                      context.navigator.pushNamed(AppScreens.allEntries),
                );
              }
              final category = expenses[index];
              return MainButton(
                expense: category,
                onTap: () =>
                    context.navigator.pushNamed(category.category.route),
              );
            },
          ),
        ),
        // const SizedBox(height: 16),
        // TextButton(
        //   onPressed: () {
        //     final date = DateTime.now();
        //     final weeks = date.monthWeaks();
        //     int i = 1;
        //     for (final week in weeks) {
        //       print('$i: ${AppFormatter().fullDate(week.first)}');
        //       i++;
        //     }
        //   },
        //   style: TextButton.styleFrom(
        //       backgroundColor: context.colorScheme.secondaryContainer,
        //       foregroundColor: context.colorScheme.onSecondaryContainer),
        //   child: const Text('get weeks'),
        // ),
      ],
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.expense,
    this.isHistory = false,
    required this.onTap,
  });
  final Function() onTap;
  final ExpenseCategory? expense;
  final bool isHistory;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Material(
        color: expense?.category.color ?? Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.grey.shade300,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isHistory
                            ? Text(
                                'History'.toUpperCase(),
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                _label(context, expense!.category),
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        isHistory
                            ? const SizedBox.shrink()
                            : Text(
                                '${AppFormatter().currency(expense?.amount ?? 0)} ${context.currency}',
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Spacer(),
                      FaIcon(
                        FontAwesomeIcons.arrowUpRightDots,
                        color: expense?.category.accentColor ?? Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _label(BuildContext context, ButtonCategory category) {
    switch (category) {
      case ButtonCategory.day:
        return context.translate.day;
      case ButtonCategory.week:
        return context.translate.week;
      case ButtonCategory.month:
        return context.translate.month;
    }
  }
}