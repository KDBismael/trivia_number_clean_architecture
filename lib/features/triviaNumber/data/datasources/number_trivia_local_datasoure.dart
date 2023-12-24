import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_number/core/errors/exceptions.dart';
import 'package:trivia_number/features/triviaNumber/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource{
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const String CACHED_NUMBER_TRIVIA='CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDatasourceImpl implements NumberTriviaLocalDatasource{
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
   final jsonString=sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
   if(jsonString!=null){
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
   }else {
    throw CacheException();
  }
  }
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    sharedPreferences.setString(CACHED_NUMBER_TRIVIA, json.encode(triviaToCache.toJson()));
    return Future.value(null);
  }
}