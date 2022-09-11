import 'package:basicbankingsystem/screen/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async{

  await Firebase.initializeApp(
    options:FirebaseOptions(
      apiKey: "null", 
      appId: '1:814302631311:android:3ae5d0f011450ddb01e7fa', 
      messagingSenderId: "null", 
      projectId: "bankingapp-b3a2f")
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: LandingPage(),
                  );
                });
            
          }
          return Container(child: Text("went wrong"),);
        });
  }
}
