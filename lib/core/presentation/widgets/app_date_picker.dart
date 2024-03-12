//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/use_cases/date_formatter.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    this.restorationId = '',
    required this.onChange,
    this.initialDate,
  });

  final String restorationId;
  final Function(DateTime) onChange;
  final DateTime? initialDate;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> with RestorationMixin {
  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleBloc>().state;
    return TextButton(
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(top: 8, bottom: 12, left: 16, right: 16),
        foregroundColor: Colors.grey.shade700,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(AppFormatter()
              .arabicDate(_selectedDate.value, locale: locale.appLang)),
          const SizedBox(width: 4),
          Icon(
            Icons.calendar_month,
            color: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  late RestorableDateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = RestorableDateTime(widget.initialDate ?? DateTime.now());
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
      });
      widget.onChange(newSelectedDate);
    }
  }

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialCalendarMode: DatePickerMode.day,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments as int),
          firstDate: DateTime(2023),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }
}
