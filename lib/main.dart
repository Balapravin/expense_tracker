
import 'package:tracker/bloc/add_expense/add_expense_bloc.dart';
import 'package:tracker/firebase_options.dart';
import 'package:tracker/routes/index.dart';
import 'package:tracker/utils/tracker_path_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<FcmAuthenticationBloc>(
          create: (BuildContext context) => FcmAuthenticationBloc()),
      BlocProvider<AddExpenseBloc>(
          create: (BuildContext context) => AddExpenseBloc())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: TrackerColour.kBackgroundColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: PageRoutes().defaultRoute(),
      routes: PageRoutes().routes(),
    );
  }
}
