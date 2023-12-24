import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_number/core/utils/input_converter.dart';
import 'package:trivia_number/core/utils/platform/network_info.dart';
import 'package:trivia_number/features/triviaNumber/data/datasources/number_trivia_local_datasoure.dart';
import 'package:trivia_number/features/triviaNumber/data/datasources/number_trivia_remote_datasoure.dart';
import 'package:trivia_number/features/triviaNumber/data/repositories/number_trivia_repository_impl.dart';
import 'package:trivia_number/features/triviaNumber/domain/repositories/number_trivia_repository.dart';
import 'package:trivia_number/features/triviaNumber/domain/usecase/get_concrete_number_trivia.dart';
import 'package:trivia_number/features/triviaNumber/domain/usecase/get_random_number_trivia.dart';
import 'package:trivia_number/features/triviaNumber/presentation/provider/number_trivia_provider.dart';

final getIt = GetIt.instance;

Future<void> InjectionsInit() async {
  // Features

  // Provider
  getIt.registerFactory(
    () => NumberTriviaProvider(
      getConcreteNumberTrivia: getIt(),
      getRandomNumberTrivia: getIt(),
      inputConverter: getIt(),
    ),
  );
  //usecases
  getIt.registerLazySingleton(
      () => GetConcreteNumberTrivia(repository: getIt()));
  getIt.registerLazySingleton(() => GetRandomNumberTrivia(repository: getIt()));

  // repositories
  getIt.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDatasource: getIt(),
      localDatasource: getIt(),
      networkInfo: getIt(),
    ),
  );

  //data sources
  getIt.registerLazySingleton<NumberTriviaRemoteDatasource>(
    () => NumberTriviaRemoteDatasourceImpl(
      httpClient: getIt(),
    ),
  );
  getIt.registerLazySingleton<NumberTriviaLocalDatasource>(
    () => NumberTriviaLocalDatasourceImpl(
      sharedPreferences: getIt(),
    ),
  );

  // Core¬
  getIt.registerLazySingleton(() => InputConverter());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      getIt(),
    ),
  );

  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton(
    () => sharedPreferences,
  );
  getIt.registerLazySingleton(() => Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
