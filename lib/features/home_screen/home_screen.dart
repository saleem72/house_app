// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:house_app/configuration/routing/app_screens.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';

import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';
import 'package:house_app/core/presentation/widgets/add_new_entry_dialog.dart';
import 'package:house_app/features/home_screen/domian/models/monthly_statistics.dart';

import 'domian/models/button_category.dart';
import 'presentation/statistic_bloc/statistic_bloc.dart';

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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<StatisticBloc, StatisticState>(
            builder: (context, state) {
              return switch (state) {
                HomeInitial() => _emptyStatistic(),
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

  Widget _emptyStatistic() {
    return const SizedBox.shrink();
  }

  Column _content(BuildContext context, MonthlyStatistics status) {
    var size = context.mediaQuery.size;

    /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double widgetWidth = size.width;
    final double gridWidth = widgetWidth - 8;
    const double ratio = 0.75;
    final expenses = status.list();
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

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.expense,
    this.isHistory = false,
    required this.onTap,
  });
  final Function() onTap;
  final ExpenseCategoryWithPercent? expense;
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
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isHistory
                              ? Text(
                                  'History'.toUpperCase(),
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  _label(context, expense!.category),
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          expense?.category == ButtonCategory.inCome
                              ? const SizedBox.shrink()
                              : Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: expense?.percent.percentColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${expense!.percent}%',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                            color: Colors.white, fontSize: 10),
                                  )),
                                )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Left: ',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            AppFormatter().currency(expense?.left ?? 0),
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          )
                        ],
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FaIcon(
                      FontAwesomeIcons.arrowUpRightDots,
                      color: expense?.category.accentColor ?? Colors.black,
                    ),
                  ),
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
      case ButtonCategory.inCome:
        return context.translate.income;
    }
  }
}
