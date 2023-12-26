import 'dart:convert';

import 'package:http/http.dart';
import 'package:trivia_number/core/errors/exceptions.dart';
import 'package:trivia_number/features/triviaNumber/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource {
  final Client httpClient;
  NumberTriviaRemoteDatasourceImpl({required this.httpClient});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return getTriviaFromUrl('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return getTriviaFromUrl('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> getTriviaFromUrl(String path) async {
    Uri url = Uri.parse(path);
    Response res = await httpClient
        .get(url, headers: {'Content-Type': 'application/json'});
    print(res.body);
    if (res.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(res.body));
    } else {
      throw ServerExceptions();
    }
  }
}
