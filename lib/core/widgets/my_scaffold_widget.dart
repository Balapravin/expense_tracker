import 'package:tracker/utils/tracker_path_export.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final String? appBarTitle;
  final Function()? floatingActionButtonOnTap;
  final bool? showLoader;
  const MyScaffold(
      {super.key,
      required this.child,
      this.appBarTitle,
      this.floatingActionButtonOnTap,
      this.showLoader});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: TrackerColour.kBackgroundColor,
          title: Text(
            appBarTitle ?? "",
          ),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white, size: 36),
        ),
        floatingActionButton: floatingActionButtonOnTap != null
            ? FloatingActionButton(
                onPressed: floatingActionButtonOnTap,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )
            : null,
        body: SafeArea(
          child: child,
        ));
  }
}
