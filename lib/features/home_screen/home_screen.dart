// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:house_app/configuration/routing/app_screens.dart';

import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/widgets/add_new_entry_dialog.dart';
import 'package:house_app/features/home_screen/domian/models/monthly_statistics.dart';

import 'presentation/statistic_bloc/statistic_bloc.dart';
import 'presentation/widgets/main_button.dart';
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
        backgroundColor: const Color(0xFFFDEBF9),
        title: Text(
          context.translate.home,
          style: context.textTheme.titleLarge?.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => _dialogBuilder(context),
            icon: const FaIcon(FontAwesomeIcons.moneyBill1Wave),
          ),
          IconButton(
            onPressed: () => context.navigator.pushNamed(AppScreens.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => _emptyStatistic(),
            HomeLoading() => const Center(child: CircularProgressIndicator()),
            HomeSuccess() => _content(context, state.expenses)
          };
        },
      ),
    );
  }

  Widget _emptyStatistic() {
    return const SizedBox.shrink();
  }

  Column _content(BuildContext context, MonthlyStatistics status) {
    var size = context.mediaQuery.size;
    final double widgetWidth = size.width;
    final double gridWidth = widgetWidth - 8;
    const double ratio = 0.75;
    final expenses = status.list();
    return Column(
      children: [
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
            // color: Colors.green,
            child: MonthlyChart(status: status),
          ),
        ),
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    // final date = context.read<HomeBloc>().date;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddNewEntryProvider(
          initialDate: DateTime.now(),
          isIncome: true,
        );
      },
    );
  }
}
