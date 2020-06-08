import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcoms/services/api_service.dart';
import 'package:matcoms/ui/my_homepage.dart';

void setup(){
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService());
}
void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'MatCom'),
    );
  }
}

