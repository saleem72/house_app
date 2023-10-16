//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/presentation/widgets/linear_progress.dart';
import 'package:house_app/features/home_screen/presentation/statistic_bloc/statistic_bloc.dart';

class DailyLinearProgressBar extends StatelessWidget {
  const DailyLinearProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticBloc, StatisticState>(
      builder: (context, state) {
        return state is HomeSuccess
            ? LinearProgressBar(
                percent: state.expenses.dayPercent,
                borderWidth: 10,
              )
            : const SizedBox.shrink();
      },
    );
  }
}
