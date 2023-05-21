import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plusvalia/add_investment.dart';

class MyInvestment extends StatefulWidget {
  const MyInvestment({Key? key}) : super(key: key);

  @override
  State<MyInvestment> createState() => _MyInvestmentState();
}

class _MyInvestmentState extends State<MyInvestment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('My Investments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
           width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Investment').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                      String monthSpell=_Month(ds['month']);
                      return Container(
                        alignment: Alignment.center,
                        //color: Colors.amber,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(ds['image']),
                              radius: 70,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text('\$ '+ds['value'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                            SizedBox(
                              height: 7,
                            ),
                            Text(ds['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                              ),),
                            SizedBox(
                              height: 7,
                            ),
                            Text(monthSpell+" "+ds['day']+","+ds['year'],
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                              ),)
                          ],
                        ),
                      );
                    });
              }
              // else if(!snapshot.hasData){
              // return Center(child: Text('Add New Data',
              // style: TextStyle(
              // color: Colors.black,
              // fontSize: 14,
              // fontWeight: FontWeight.bold
              // ),));
              // }
              else
                return Container();
            },
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddInvestment()));
      },
        backgroundColor: Colors.black,
        child: Text('+',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.white
        ),),
      ),
    );
  }
  String _Month(String month){
    switch(month){
      case "1":
        {
          return "January";

        }
      case "2":
        {
          return "February";

        }
      case "3":
        {
          return "March";

        }
      case "4":
        {
          return "April";

        }
      case "5":
        {
          return "May";

        }
      case "6":
        {
          return "June";

        }
      case "7":
        {
          return "July";

        }
      case "8":
        {
          return "August";

        }
      case "9":
        {
          return "September";

        }
      case "10":
        {
          return "October";

        }
      case "11":
        {
          return "November";

        }
      case "12":
        {
          return "December";

        }
      default: { return "null"; }
    }
  }
}
