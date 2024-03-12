//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/widgets/app_drawer.dart';

import 'presentation/statistic_bloc/statistic_bloc.dart';
import 'presentation/widgets/main_button.dart';
import 'presentation/widgets/month_lefts_view.dart';
import 'presentation/widgets/monthly_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) =>
    //       StatisticBloc(repository: HomeRepository(db: locator()))
    //         ..add(HomeSubscribeEvent()),
    //   child: const _HomeScreen(),
    // );
    return const _HomeScreen();
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        // backgroundColor: const Color(0xFFFDEBF9),
        title: Text(
          context.translate.home,
          style: context.textTheme.titleLarge?.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<StatisticBloc>().add(StatisticTestDataEvent()),
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      body: BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) {
          return _content(context, state);
        },
      ),
      drawer: const AppDrawer(),
    );
  }

  Column _content(BuildContext context, StatisticState status) {
    var size = context.mediaQuery.size;
    final double widgetWidth = size.width;
    final double gridWidth = widgetWidth - 8;
    const double ratio = 0.75;
    final expenses = status.expenses.list();
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MonthLeftsView(
            statistics: status.expenses,
          ),
        ),
        const SizedBox(height: 8),
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
            itemCount: expenses.length,
            itemBuilder: (BuildContext context, int index) {
              final category = expenses[index];
              return MainButton(
                expense: category,
                onTap: () =>
                    context.navigator.pushNamed(category.category.route),
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            // padding: const EdgeInsets.only(top: 8),
            child: Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 32, left: 8, right: 8, bottom: 48),
                child: MonthlyChart(status: status.dailySpending),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
