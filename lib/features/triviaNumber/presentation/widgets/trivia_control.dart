import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_number/features/triviaNumber/presentation/provider/number_trivia_provider.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    super.key,
  });

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            controller.clear();
            Provider.of<NumberTriviaProvider>(context, listen: false)
                .eitherFailureOrConcreteTrivia(input: inputStr);
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                ),
                // color: Theme.of(context).hintColor,
                // textTheme: ButtonTextTheme.primary,
                onPressed: () {
                  controller.clear();
                  Provider.of<NumberTriviaProvider>(context, listen: false)
                      .eitherFailureOrConcreteTrivia(input: inputStr);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                child: const Text('Get random trivia'),
                onPressed: () {
                  controller.clear();
                  Provider.of<NumberTriviaProvider>(context, listen: false)
                      .eitherFailureOrRandomTrivia();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
