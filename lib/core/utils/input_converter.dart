import 'package:dartz/dartz.dart';
import 'package:trivia_number/core/errors/faillure.dart';

class InputConverter {
  Either<Faillure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Faillure {}
