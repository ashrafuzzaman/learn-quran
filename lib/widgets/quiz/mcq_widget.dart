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
  bool submitted = false;

  onSubmit() async {
    if (selectedOption == null) {
      return;
    }
    await MCQAttemptRepo()
        .recordAttempt(widget.question.word.id, selectedOption!.isCorrect);
    setState(() {
      submitted = true;
    });
    if (!widget.showNext) {
      widget.onComplete(selectedOption!.isCorrect);
    }
  }

  onNext() async {
    widget.onComplete(selectedOption!.isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    var successColor =
        Theme.of(context).extension<ThemeExtensionColors>()!.success;
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
                tileColor: submitted && option.isCorrect
                    ? successColor
                    : Colors.transparent,
                leading: Radio<String>(
                  value: option.title.text,
                  groupValue:
                      selectedOption != null ? selectedOption!.title.text : '',
                  onChanged: (_) {
                    setState(() {
                      selectedOption = option;
                    });
                    onSubmit();
                  },
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.showNext
                ? [
                    const SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                      text: 'Next',
                      onPressed: submitted != true
                          ? null
                          : () async => {await onNext()},
                    )
                  ]
                : [],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  const CustomButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onPressed: onPressed != null ? () => {onPressed!()} : null,
      child: Text(text),
    );
  }
}
