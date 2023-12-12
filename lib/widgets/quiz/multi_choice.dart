import 'package:flutter/material.dart';
import 'package:learnquran/dto/multi_Choice_quiz.dart';
import 'package:learnquran/dto/quiz_option.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';
import 'package:learnquran/widgets/text/arabic_text.dart';

class MultiChoiceQuizWidget extends StatefulWidget {
  final MultiChoiceQuiz quiz;

  const MultiChoiceQuizWidget({super.key, required this.quiz});

  @override
  State<MultiChoiceQuizWidget> createState() => _MultiChoiceQuizWidgetState();
}

class _MultiChoiceQuizWidgetState extends State<MultiChoiceQuizWidget> {
  QuizOption? selectedOption;
  bool submitted = false;

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
              widget.quiz.title.text,
              fontSize: 48,
            ),
          ),
          ...widget.quiz.options.map((option) => ListTile(
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
                  },
                ),
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onPressed: selectedOption == null || submitted == true
                ? null
                : () {
                    setState(() {
                      submitted = true;
                    });
                  },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
