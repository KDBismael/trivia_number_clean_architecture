import 'package:dartz/dartz.dart';
import 'package:trivia_number/core/errors/exceptions.dart';
import 'package:trivia_number/core/errors/faillure.dart';
import 'package:trivia_number/core/utils/platform/network_info.dart';
import 'package:trivia_number/features/triviaNumber/data/datasources/number_trivia_local_datasoure.dart';
import 'package:trivia_number/features/triviaNumber/data/datasources/number_trivia_remote_datasoure.dart';
import 'package:trivia_number/features/triviaNumber/data/models/number_trivia_model.dart';
import 'package:trivia_number/features/triviaNumber/domain/entity/number_trivia.dart';
import 'package:trivia_number/features/triviaNumber/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

NumberTriviaRepositoryImpl({required this.remoteDatasource,required this.localDatasource,required this.networkInfo});

  @override
  Future<Either<Faillure, NumberTriviaEntity>> getConcreteNumberTrivia(int number)async {
    return _getTrivia(() => remoteDatasource.getConcreteNumberTrivia(number));
  }
  @override
  Future<Either<Faillure, NumberTriviaEntity>> getRandomNumberTrivia() async{
    return _getTrivia(() => remoteDatasource.getRandomNumberTrivia());
  }

  Future<Either<Faillure, NumberTriviaEntity>> _getTrivia(Future<NumberTriviaModel> Function() getRandomOrConcrete )async{
    if(await networkInfo.isConnected){
      try{
        final remoteTrivia=await getRandomOrConcrete();
        localDatasource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerExceptions{
        return Left(ServerFaillure());
      }
    }else{
      try{
        final localTrivia=await localDatasource.getLastNumberTrivia();
        return Right(localTrivia);
      }on CacheException{
        return Left(CacheFaillure());
      }
    }
  }
}