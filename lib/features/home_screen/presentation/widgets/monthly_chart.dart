//

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/features/home_screen/domian/models/monthly_statistics.dart';

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({
    super.key,
    required this.status,
  });

  final MonthlyStatistics status;
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    // const style = TextStyle(
    //   fontWeight: FontWeight.bold,
    //   fontSize: 16,
    // );
    Widget text;
    switch (value.toInt()) {
      // case 2:
      //   text = const Text('SEPT', style: style);
      //   break;
      // case 7:
      //   text = const Text('OCT', style: style);
      //   break;
      // case 12:
      //   text = const Text('DEC', style: style);
      //   break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      // case 1:
      //   text = '1m';
      //   break;
      // case 2:
      //   text = '2m';
      //   break;
      // case 3:
      //   text = '3m';
      //   break;
      // case 4:
      //   text = '5m';
      //   break;
      // case 5:
      //   text = '6m';
      //   break;
      default:
        text = '';
        break;
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  @override
  Widget build(BuildContext context) {
    final LineTouchData lineTouchData1 = LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
    );

    const FlGridData gridData = FlGridData(show: false);

    final SideTitles bottomTitles = SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: bottomTitleWidgets,
    );

    SideTitles leftTitles() => SideTitles(
          getTitlesWidget: leftTitleWidgets,
          showTitles: true,
          interval: 1,
          reservedSize: 20,
        );

    final FlTitlesData titlesData1 = FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles,
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles(),
      ),
    );

    FlBorderData borderData = FlBorderData(
      show: true,
      border: Border(
        bottom: BorderSide(
          color: context.colorScheme.primary.withOpacity(0.2),
          width: 4,
        ),
        left: const BorderSide(color: Colors.transparent),
        right: const BorderSide(color: Colors.transparent),
        top: const BorderSide(color: Colors.transparent),
      ),
    );

    final spots = status.dailySpendings
        .map((e) => FlSpot(e.day.toDouble(), e.spendings.toDouble()))
        .toList();

    LineChartBarData lineChartBarData1_1 = LineChartBarData(
      isCurved: true,
      color: Colors.green.shade300,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      // spots: const [
      //   FlSpot(1, 1),
      //   FlSpot(3, 1.5),
      //   FlSpot(5, 1.4),
      //   FlSpot(7, 3.4),
      //   FlSpot(10, 2),
      //   FlSpot(12, 2.2),
      //   FlSpot(13, 1.8),
      // ],
      spots: const [
        // FlSpot(10.0, 53403.0),
        // FlSpot(11.0, 40918.0),
        // FlSpot(12.0, 55629.0),
        // FlSpot(13.0, 34968.0),
        // FlSpot(14.0, 34487.0),
        // FlSpot(15.0, 35841.0),
        // FlSpot(16.0, 77867.0),
        // FlSpot(17.0, 71936.0),
        // FlSpot(18.0, 43527.0),
        // FlSpot(19.0, 31161.0),
        // FlSpot(20.0, 21441.0),
        // FlSpot(21.0, 62960.0),
        // FlSpot(22.0, 5623.0),
        // FlSpot(23.0, 47730.0),
        // FlSpot(24.0, 36675.0),
        // FlSpot(25.0, 54683.0),
        // FlSpot(26.0, 64937.0),
        // FlSpot(27.0, 31558.0),
        // FlSpot(28.0, 5021.0),
        // FlSpot(29.0, 1078654.0),
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
    );

    LineChartBarData lineChartBarData1_2 = LineChartBarData(
      isCurved: true,
      color: AppColors.contentColorPink,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: false,
        color: AppColors.contentColorPink.withOpacity(0),
      ),
      spots: const [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
    );

    LineChartBarData lineChartBarData1_3 = LineChartBarData(
      isCurved: true,
      color: AppColors.contentColorCyan,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: const [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
    );

    List<LineChartBarData> lineBarsData1 = [
      lineChartBarData1_1,
      // lineChartBarData1_2,
      // lineChartBarData1_3,
    ];

    final data = LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      // minX: status.dailySpendings
      //     .reduce((value, element) =>
      //         element.spendings < value.spendings ? element : value)
      //     .spendings
      //     .toDouble(),
      // maxX: status.dailySpendings
      //     .reduce((value, element) =>
      //         element.spendings > value.spendings ? element : value)
      //     .spendings
      //     .toDouble(),
      // maxY: 31,
      // minY: 1,
    );
    return LineChart(
      data,
      duration: const Duration(milliseconds: 150), // Optional
      curve: Curves.linear, // Optional
    );
  }
}
