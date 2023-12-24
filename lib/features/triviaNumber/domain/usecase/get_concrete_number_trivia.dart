import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_number/core/domain/usecase/base_usecase.dart';
import 'package:trivia_number/core/errors/faillure.dart';
import 'package:trivia_number/features/triviaNumber/domain/entity/number_trivia.dart';
import 'package:trivia_number/features/triviaNumber/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia extends BaseUsecase<NumberTriviaEntity, Params> {
  final NumberTriviaRepository repository;
  GetConcreteNumberTrivia({required this.repository});

  @override
  Future<Either<Faillure, NumberTriviaEntity>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;
  const Params({required this.number});

  @override
  List get props => [number];
}

class Noparams {}
