//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domian/models/entry.dart';
import 'package:house_app/core/domian/usecases/date_formatter.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/blocs/add_entry_bloc/add_entry_bloc.dart';
import 'package:house_app/dependancy_injection.dart' as di;

import '../../domian/input_formatters/currency_formatter.dart';
import 'core_widgets.dart';

class AddNewEntryProvider extends StatelessWidget {
  const AddNewEntryProvider({super.key, this.initialDate, this.entry});
  final DateTime? initialDate;
  final Entry? entry;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddEntryBloc>(
      create: (context) => AddEntryBloc(
        db: di.locator(),
        date: initialDate ?? DateTime.now(),
        entry: entry,
      ),
      child: AddNewEntryDialog(
        initialDate: initialDate ?? DateTime.now(),
        entry: entry,
      ),
    );
  }
}

class AddNewEntryDialog extends StatefulWidget {
  const AddNewEntryDialog({
    super.key,
    required this.initialDate,
    this.entry,
  });
  final DateTime initialDate;
  final Entry? entry;
  @override
  State<AddNewEntryDialog> createState() => _AddNewEntryDialogState();
}

class _AddNewEntryDialogState extends State<AddNewEntryDialog> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _amount.text = AppFormatter().currency(widget.entry!.amount);
      _description.text = widget.entry!.description;
    }
  }

  @override
  void dispose() {
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(28),
              //   topRight: Radius.circular(28),
              // ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.entry == null
                      ? context.translate.new_entry_title
                      : context.translate.update_entry_title,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.translate.date,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppDatePicker(
                        initialDate: widget.initialDate,
                        onChange: (date) => context
                            .read<AddEntryBloc>()
                            .add(AddEntryDateChangedEvent(date: date)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    label: context.translate.amount,
                    hint: '10,000',
                    controller: _amount,
                    inputFormatters: [
                      CurrencyInputFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (amount) => context
                        .read<AddEntryBloc>()
                        .add(AddEntryAmountChangedEvent(anmount: amount)),
                  ),
                  const SizedBox(height: 16),
                  AppTextFieldWithSpeech(
                    label: context.translate.description,
                    hint: context.translate.description,
                    controller: _description,
                    onSpeechRecognition: (text) {
                      context.read<AddEntryBloc>().add(
                          AddEntryDescriptionChangedEvent(description: text));
                    },
                    onChanged: (description) => context
                        .read<AddEntryBloc>()
                        .add(AddEntryDescriptionChangedEvent(
                            description: description)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: Text(context.translate.cancel),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      AddEntryAddButton(
                        onPressed: () {
                          _amount.clear();
                          _description.clear();
                          context
                              .read<AddEntryBloc>()
                              .add(AddEntrySubmitEvent());
                          // Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddEntryAddButton extends StatelessWidget {
  const AddEntryAddButton({
    super.key,
    required this.onPressed,
  });
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEntryBloc, AddEntryState>(
      builder: (context, state) {
        return _buildButton(context, state.isValid);
      },
    );
  }

  TextButton _buildButton(BuildContext context, bool isValid) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      onPressed: isValid ? onPressed : null,
      child: Text(context.translate.add),
    );
  }
}
