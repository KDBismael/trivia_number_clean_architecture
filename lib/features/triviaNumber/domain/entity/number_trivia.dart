import 'package:equatable/equatable.dart';

class NumberTriviaEntity extends Equatable{
  final String text;
  final int number;
  const NumberTriviaEntity({required this.number,required this.text});

  @override
  List<Object> get props=><Object>[text,number];
}