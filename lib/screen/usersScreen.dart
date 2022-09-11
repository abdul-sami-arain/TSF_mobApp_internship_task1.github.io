import 'package:basicbankingsystem/screen/customerProfile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _collectionStream =
        FirebaseFirestore.instance.collection('AccountDetails').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _collectionStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            // backgroundColor: Color.fromRGBO(215, 221, 233, 1),
            appBar: AppBar(
              centerTitle: true,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ), 
              backgroundColor: Color.fromRGBO(118, 166, 240, 1),
              title: Text("Users list"),
            ),
            body: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerProfile(
                                account: data['acc#'],
                                amount: data['amount'],
                                email: data['email'],
                                name: data['name'],
                                phone: data['phone'],
                                nic: data['nic'],
                              )),
                    );
                    print(data['key']);
                  },
                  child: ListTile(
                    title: Container(
                        color: Color.fromRGBO(249, 206, 223, 1),
                        child: Text(data['nic'])),
                    subtitle: Container(
                        color: Color.fromRGBO(252, 225, 134, 1),
                        child: Text(data['acc#'])),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
