import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_number/features/triviaNumber/presentation/provider/number_trivia_provider.dart';
import 'package:trivia_number/features/triviaNumber/presentation/screens/number_trivia.dart';
import 'package:trivia_number/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionsInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => getIt<NumberTriviaProvider>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green.shade800,
        ),
        debugShowCheckedModeBanner: false,
        home: const NumberTrivia(),
      ),
    );
  }
}
