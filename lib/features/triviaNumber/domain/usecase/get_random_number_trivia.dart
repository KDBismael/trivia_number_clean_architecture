import 'package:dartz/dartz.dart';
import 'package:trivia_number/core/domain/usecase/base_usecase.dart';
import 'package:trivia_number/core/errors/faillure.dart';
import 'package:trivia_number/features/triviaNumber/domain/entity/number_trivia.dart';
import 'package:trivia_number/features/triviaNumber/domain/repositories/number_trivia_repository.dart';
import 'package:trivia_number/features/triviaNumber/domain/usecase/get_concrete_number_trivia.dart';

class GetRandomNumberTrivia extends BaseUsecase<NumberTriviaEntity,Noparams>{
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia({required this.repository});

  @override
  Future<Either<Faillure, NumberTriviaEntity>> call(params) async {
    return await repository.getRandomNumberTrivia();
  }
}