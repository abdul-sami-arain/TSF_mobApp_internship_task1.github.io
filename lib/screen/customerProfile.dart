import 'package:basicbankingsystem/styles/heading1.dart';
import 'package:basicbankingsystem/styles/heading3.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerProfile extends StatelessWidget {
  final NicNumber = TextEditingController();
  final AmountTransfer = TextEditingController();
  final String name;
  final String email;
  final String phone;
  final String account;
  final int amount;
  final String nic;
  CustomerProfile(
      {Key? key,
      required this.name,
      required this.email,
      required this.phone,
      required this.account,
      required this.amount,
      required this.nic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future alertBox() async {
      if (amount >= int.parse(AmountTransfer.text)) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('AccountDetails')
                .doc(NicNumber.text)
                .get();

        DocumentSnapshot<Map<String, dynamic>> snapshot2 =
            await FirebaseFirestore.instance
                .collection('AccountDetails')
                .doc(nic)
                .get();        

        if (snapshot['nic'] == nic) {
          print("Invalid CNIC");
        } else {
          FirebaseFirestore.instance
              .collection('AccountDetails')
              .doc(NicNumber.text)
              .update({
            'amount': int.parse(AmountTransfer.text) + snapshot['amount']
          }).then((value) => print("object"));
          FirebaseFirestore.instance
              .collection('AccountDetails')
              .doc(nic)
              .update({
            'amount': snapshot2['amount'] -int.parse(AmountTransfer.text) 
          }).then((value) => print("object"));
        }
      } else {}
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(215, 157, 180, 1),
        appBar: AppBar(
           centerTitle: true,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ), 
          backgroundColor: Color.fromRGBO(118, 166, 240, 1),
          title: Text(name),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Head1(heading: "Details of Account", R: 255, G: 255, B: 255),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Head3(heading: "Name", R: 255, G: 255, B: 255),
                Head3(heading: name, R: 255, G: 255, B: 255)
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Head3(heading: "Email", R: 255, G: 255, B: 255),
                Head3(heading: email, R: 255, G: 255, B: 255)
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Head3(heading: "Phone#", R: 255, G: 255, B: 255),
                Head3(heading: phone, R: 255, G: 255, B: 255)
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Head3(heading: "Amount", R: 255, G: 255, B: 255),
                Head3(heading: amount.toString(), R: 255, G: 255, B: 255)
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Head3(heading: "Account#", R: 255, G: 255, B: 255),
                Head3(heading: account, R: 255, G: 255, B: 255)
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(118, 166, 240, 1)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: AlertDialog(
                            title: Head1(
                              B: 215,
                              G: 157,
                              R: 180,
                              heading: 'Tranfer Amount Details',
                            ),
                            content: Container(
                              height: 150.h,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: NicNumber,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),

                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration:
                                        InputDecoration(hintText: "CNIC"),
                                  ),
                                  TextField(
                                    controller: AmountTransfer,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                      // for version 2 and greater youcan also use this
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                        hintText: "Amount Transferring"),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(118, 166, 240, 1)),
                                  ),
                                  onPressed: () {
                                    alertBox();
                                    Navigator.pop(context);
                                    print(NicNumber.text);
                                  },
                                  child: Text("Transfer"))
                            ],
                          ),
                        );
                      });
                },
                child: Text("Transfer"))
          ]),
        ),
      ),
    );
  }
}
