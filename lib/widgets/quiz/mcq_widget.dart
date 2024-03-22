import 'package:flutter/material.dart';
import 'package:learnquran/dto/multi_Choice_question.dart';
import 'package:learnquran/dto/mcq_option.dart';
import 'package:learnquran/repository/mcq_attempt_repo.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';
import 'package:learnquran/widgets/text/arabic_text.dart';

class MCQWidget extends StatefulWidget {
  final MultiChoiceQuestion question;
  final Function(bool) onComplete;
  final bool showNext;

  const MCQWidget(
      {super.key,
      this.showNext = false,
      required this.question,
      required this.onComplete});

  @override
  State<MCQWidget> createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  MCQOption? selectedOption;
  static const autoOnCompleteInvocationDelayInMS = 600;

  onSubmit(MCQOption option) async {
    setState(() {
      selectedOption = option;
    });

    await MCQAttemptRepo()
        .recordAttempt(widget.question.word.id, option.isCorrect);

    Future.delayed(
        const Duration(milliseconds: autoOnCompleteInvocationDelayInMS), () {
      if (mounted) {
        widget.onComplete(option.isCorrect);
      }
    });
  }

  Color? getOptionBackgroundColor(
      MCQOption option,
      Color? correctSelectionColor,
      Color? incorrectSelectionColor,
      Color notSelectedColor) {
    if (selectedOption == null) return notSelectedColor;
    if (option.isCorrect) return correctSelectionColor;
    if (option.title != selectedOption?.title) return notSelectedColor;
    return incorrectSelectionColor;
  }

  @override
  Widget build(BuildContext context) {
    var successColor =
        Theme.of(context).extension<ThemeExtensionColors>()!.success;
    var failureColor =
        Theme.of(context).extension<ThemeExtensionColors>()!.failure;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ArabicText(
              widget.question.title.text,
              fontSize: 48,
            ),
          ),
          ...widget.question.options.map((option) => ListTile(
                title: Text(
                  option.title.text,
                  style: const TextStyle(fontSize: 24),
                ),
                tileColor: getOptionBackgroundColor(
                    option, successColor, failureColor, Colors.transparent),
                leading: Radio<String>(
                  value: option.title.text,
                  groupValue:
                      selectedOption != null ? selectedOption!.title.text : '',
                  onChanged: (_) {
                    onSubmit(option);
                  },
                ),
              )),
        ],
      ),
    );
  }
}
