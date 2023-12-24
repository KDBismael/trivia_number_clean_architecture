import 'package:dartz/dartz.dart';
import 'package:trivia_number/core/errors/faillure.dart';

abstract class BaseUsecase<Type, Params>{
  Future<Either<Faillure,Type>> call (Params params);
}