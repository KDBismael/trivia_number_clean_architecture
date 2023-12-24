import 'package:flutter/material.dart';
import 'package:trivia_number/features/triviaNumber/presentation/provider/number_trivia_provider.dart';
import 'package:trivia_number/features/triviaNumber/presentation/widgets/widgets.dart';

class TopHalf extends StatefulWidget {
  final NumberTriviaState numberTrivia;
  const TopHalf({super.key, required this.numberTrivia});

  @override
  State<TopHalf> createState() => _TopHalfState();
}

class _TopHalfState extends State<TopHalf> {
  @override
  Widget build(BuildContext context) {
    if (widget.numberTrivia is Empty) {
      return MessageDisplay(
        message: 'Start searching!',
      );
    } else if (widget.numberTrivia is Loading) {
      return const LoadingWidget();
    } else if (widget.numberTrivia is Loaded) {
      return TriviaDisplay(
        numberTrivia: (widget.numberTrivia as Loaded).trivia,
      );
    } else if (widget.numberTrivia is Error) {
      return MessageDisplay(
        message: (widget.numberTrivia as Error).message,
      );
    } else
      return Text('');
  }
}
