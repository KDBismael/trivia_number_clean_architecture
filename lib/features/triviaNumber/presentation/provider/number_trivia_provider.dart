import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_number/core/errors/faillure.dart';
import 'package:trivia_number/core/utils/input_converter.dart';
import 'package:trivia_number/features/triviaNumber/domain/entity/number_trivia.dart';
import 'package:trivia_number/features/triviaNumber/domain/usecase/get_concrete_number_trivia.dart';
import 'package:trivia_number/features/triviaNumber/domain/usecase/get_random_number_trivia.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaProvider extends ChangeNotifier {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaProvider(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter});
  NumberTriviaState triviaState = Empty();

  void eitherFailureOrConcreteTrivia({required String input}) {
    final inputEither = inputConverter.stringToUnsignedInteger(input);
    inputEither.fold((failure) {
      triviaState = Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      notifyListeners();
    }, (integer) async {
      triviaState = Loading();
      notifyListeners();
      final failureOrTrivia =
          await getConcreteNumberTrivia(Params(number: integer));
      _eitherLoadedOrErrorState(failureOrTrivia);
    });
  }

  void eitherFailureOrRandomTrivia() async {
    triviaState = Loading();
    notifyListeners();
    final failureOrTrivia = await getRandomNumberTrivia(Noparams());
    _eitherLoadedOrErrorState(failureOrTrivia);
  }

  void _eitherLoadedOrErrorState(
    Either<Faillure, NumberTriviaEntity> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        triviaState = Error(message: _mapFailureToMessage(failure));
        notifyListeners();
      },
      (trivia) {
        triviaState = Loaded(trivia: trivia);
        notifyListeners();
      },
    );
  }

  String _mapFailureToMessage(Faillure failure) {
    switch (failure.runtimeType) {
      case ServerFaillure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFaillure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

@immutable
abstract class NumberTriviaState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTriviaEntity trivia;

  Loaded({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
