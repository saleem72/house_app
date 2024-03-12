//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/core/domain/helpers/safe/safe.dart';
import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:house_app/core/presentation/widgets/core_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _currencyAR = TextEditingController();
  final TextEditingController _currencyEN = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bloc = context.read<LocaleBloc>().state;
      _currencyAR.text = bloc.currencyAR;
      _currencyEN.text = bloc.currencyEN;
    });
  }

  @override
  void dispose() {
    _currencyAR.dispose();
    _currencyEN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.settings),
      ),
      body: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return _content(context, state);
        },
      ),
    );
  }

  Widget _content(BuildContext context, LocaleState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.translate.app_lang}:',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SelectionOptions(
            options: const [SafeKeys.english, SafeKeys.arabic],
            selected: state.appLang.languageCode == 'en'
                ? SafeKeys.english
                : SafeKeys.arabic,
            onChange: (lang) {
              final Locale locale = lang == SafeKeys.english
                  ? const Locale(SafeKeys.englishCode)
                  : const Locale(SafeKeys.arabicCode);

              context
                  .read<LocaleBloc>()
                  .add(LocaleSetLocaleEvent(locale: locale));
            },
          ),
          const SizedBox(height: 16),
          Text(
            '${context.translate.speech_lang}:',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SelectionOptions(
            options: const [SafeKeys.english, SafeKeys.arabic],
            selected: state.speechLang.languageCode == 'en'
                ? SafeKeys.english
                : SafeKeys.arabic,
            onChange: (lang) {
              final Locale locale = lang == SafeKeys.english
                  ? const Locale(SafeKeys.englishCode)
                  : const Locale(SafeKeys.arabicCode);

              context
                  .read<LocaleBloc>()
                  .add(LocaleSetSpeechLocaleEvent(locale: locale));
            },
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTextField(
              controller: _currencyAR,
              label: context.translate.arabic_currency,
              onChanged: (value) => context
                  .read<LocaleBloc>()
                  .add(LocaleArabicCurrencyChangedEvent(value: value)),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTextField(
              controller: _currencyEN,
              label: context.translate.english_currency,
              onChanged: (value) => context
                  .read<LocaleBloc>()
                  .add(LocaleEnglishCurrencyChangedEvent(value: value)),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionOptions extends StatelessWidget {
  const SelectionOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.onChange,
  });
  final List<String> options;
  final String selected;
  final Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...options.map((e) => Expanded(
                child: GestureDetector(
              onTap: () => onChange(e),
              child: SelectionOptionLabel(
                label: e == SafeKeys.english
                    ? context.translate.english
                    : context.translate.arabic,
                isSelected: selected == e,
              ),
            ))),
      ],
    );
  }
}

class SelectionOptionLabel extends StatelessWidget {
  const SelectionOptionLabel({
    super.key,
    required this.label,
    required this.isSelected,
  });
  final String label;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: context.currentDirection == TextDirection.ltr
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.secondaryContainer : null,
          borderRadius: isSelected ? BorderRadius.circular(8) : null,
        ),
        child: Text(
          label,
          style: context.textTheme.titleSmall
              ?.copyWith(color: context.colorScheme.onSecondaryContainer),
        ),
      ),
    );
  }
}
