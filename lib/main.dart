import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/ui/pages/pages.dart';
import 'package:news_app/view_model/vm.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsVM(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Colors.white,
        ),
        title: 'News App',
        home: HomePage(),
      ),
    );
  }
}
