import 'package:trivia_number/features/triviaNumber/domain/entity/number_trivia.dart';

class NumberTriviaModel extends NumberTriviaEntity{
  const NumberTriviaModel({required String text,required int number}):super(number: number,text: text);
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json){
    return NumberTriviaModel(text: json['text'], number:(json['number'] as double).toInt(),);
  }
  Map<String,dynamic> toJson(){
    return {
      'text':text,
      'number':number,
    };
  }
}