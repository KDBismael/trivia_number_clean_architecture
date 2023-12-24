import 'package:dartz/dartz.dart';
import 'package:trivia_number/core/errors/faillure.dart';
import 'package:trivia_number/features/triviaNumber/domain/entity/number_trivia.dart';

abstract class NumberTriviaRepository{
  Future<Either<Faillure,NumberTriviaEntity>> getConcreteNumberTrivia(int number);
  Future<Either<Faillure,NumberTriviaEntity>> getRandomNumberTrivia();
}