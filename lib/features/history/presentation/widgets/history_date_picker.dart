//
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';

class HistoryDatePicker extends StatefulWidget {
  const HistoryDatePicker({
    super.key,
    required this.onDateChange,
  });
  final Function(DateTime) onDateChange;

  @override
  State<HistoryDatePicker> createState() => _HistoryDatePickerState();
}

class _HistoryDatePickerState extends State<HistoryDatePicker> {
  DateTime date = DateTime.now();
  final formatter = AppFormatter();
  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleBloc>().state.appLang;
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formatter.arabicMonth(date, locale: locale),
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }

  _showDatePicker(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 4,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            height: 400,
            width: 300,
            child: SfDateRangePicker(
              view: DateRangePickerView.year,
              selectionMode: DateRangePickerSelectionMode.single,
              onSelectionChanged: _onSelectionChanged,
              onViewChanged: _onViewChanged,
              minDate: DateTime(2023, 01, 25, 0, 0, 0),
              maxDate: DateTime.now(),
              headerStyle: headerStyle(),
              monthViewSettings: monthViewSettings(),
              selectionColor: Colors.green,
              todayHighlightColor: context.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }

  _onViewChanged(DateRangePickerViewChangedArgs args) {
    if (args.view == DateRangePickerView.month) {
      context.navigator.pop();
      final temp = args.visibleDateRange.startDate ?? DateTime.now();
      widget.onDateChange(temp);
      setState(() {
        date = temp;
      });
    }
  }

  _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    developer.log(args.value, name: 'history.date.picker');
  }

  DateRangePickerMonthViewSettings monthViewSettings() {
    return const DateRangePickerMonthViewSettings(
      viewHeaderStyle: DateRangePickerViewHeaderStyle(
        textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  DateRangePickerHeaderStyle headerStyle() {
    return DateRangePickerHeaderStyle(
      // backgroundColor: Colors.blue,
      textStyle: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
