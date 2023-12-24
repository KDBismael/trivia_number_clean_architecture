import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_number/features/triviaNumber/presentation/provider/number_trivia_provider.dart';
import 'package:trivia_number/features/triviaNumber/presentation/widgets/widgets.dart';

class NumberTrivia extends StatelessWidget {
  const NumberTrivia({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    NumberTriviaState numberTrivia =
        Provider.of<NumberTriviaProvider>(context).triviaState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                // Top half
                TopHalf(
                  numberTrivia: numberTrivia,
                ),
                const SizedBox(height: 20),

                // Bottom half
                const TriviaControls()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
