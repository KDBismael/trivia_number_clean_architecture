import 'package:equatable/equatable.dart';

abstract class Faillure extends Equatable{
  Faillure({required this.properties});
  List properties=const <dynamic>[];

  @override
  List get props=>[properties];
}

class ServerFaillure extends Faillure{}
class CacheFaillure extends Faillure{}