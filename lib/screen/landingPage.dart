import 'package:basicbankingsystem/screen/usersScreen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(215, 221, 233, 1),
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Color.fromRGBO(118, 166, 240, 1),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(118, 166, 240, 1)),
            ),
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UsersScreen()),);
            },
             child: Text("All Customers")
             ),
        ),
      ) ,
    );
  }
}
