//

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:house_app/core/domain/models/daily_spending.dart';

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({
    super.key,
    required this.status,
  });

  final List<DailySpending> status;

  List<FlSpot> get spots => status
      .map((e) => FlSpot(e.day.toDouble(), e.spending.toDouble()))
      .toList();

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: status.range > 0 ? status.range / 4 : null,
        reservedSize: 50,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final newValue = value ~/ 1000;

    if (value == meta.max || value == meta.min) {
      return const SizedBox.shrink();
    }

    if (value == 0) {
      final text = newValue.toString();
      return Text(text, style: style, textAlign: TextAlign.center);
    }

    final text = '${newValue.toString()}K';
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  // LineTouchData lineTouchData() => const LineTouchData(
  //       handleBuiltInTouches: true,
  //       touchTooltipData: LineTouchTooltipData(
  //         tooltipBgColor: Colors.red,
  //       ),
  //     );

  LineTouchData lineTouchData() => LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.purple,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                  'day: ${touchedSpot.x.toInt().toString()}\nSpend: ${touchedSpot.y.toInt().toString()}',
                  const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold));
            }).toList();
          },
        ),
      );

  FlGridData getGridData() => FlGridData(
        show: true,
        horizontalInterval: status.range > 0 ? status.range / 4 : null,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          if ((value ~/ 1000) == 10) {
            return const FlLine(
              color: Colors.red,
              strokeWidth: 2,
            );
          }
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
            dashArray: [8, 4],
          );
        },
      );

  FlTitlesData getTitlesData() => FlTitlesData(
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
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

  FlBorderData getBorderData() => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: Colors.grey.shade300, style: BorderStyle.solid),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData lineChartBarData() => LineChartBarData(
        isCurved: true,
        color: Colors.green.shade300,
        // .withOpacity(1), // Colors.green.shade300,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        // dotData: FlDotData(
        //   show: true,
        //   getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
        //     radius: 8,
        //     // color: lerpGradient(
        //     //   barData.colors,
        //     //   barData.colorStops!,
        //     //   percent / 100,
        //     // ),
        //     color: Colors.purple,
        //     strokeWidth: 2,
        //     strokeColor: Colors.black,
        //   ),
        // ),
        belowBarData: BarAreaData(show: false),
        spots: spots,
      );

  List<LineChartBarData> getLineBarsData() => [
        lineChartBarData(),
      ];

  ExtraLinesData getExtraLinesData() => ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
              y: 0,
              dashArray: [8, 4],
              strokeWidth: 1,
              color: Colors.red,
              label: HorizontalLineLabel(
                style: const TextStyle(
                  color: Colors.red,
                ),
                labelResolver: (hLine) {
                  return 'Hello'; // hLine.y.toInt().toString();
                },
              )),
        ],
      );

  LineChartData data() => LineChartData(
        lineTouchData: lineTouchData(),
        gridData: getGridData(),
        titlesData: getTitlesData(),
        borderData: getBorderData(),
        lineBarsData: getLineBarsData(),
        extraLinesData: getExtraLinesData(),
        minX: 1,
        maxX: 31,
        minY: status.minY,
        maxY: status.maxY,
      );

  @override
  Widget build(BuildContext context) {
    return LineChart(
      data(),
      duration: const Duration(milliseconds: 150), // Optional
      curve: Curves.linear, // Optional
    );
  }
}
