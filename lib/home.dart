import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // static final DateTime now = DateTime.now();
  // static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  // final String fianldate = formatter.format(now);
  String name=" ";
  String value="";
  String percentage="";
  double sumInvest=0.0;
  String day=" ";
  String month="";
  String year="";
  String Pmonth="";
  String Pyear="";
  void sum() async{
    await FirebaseFirestore.instance
        .collection("Investment")
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((doc) {
        sumInvest = sumInvest + double.parse(doc["value"]);
      });
    });
    print(sumInvest);
  }
  void date() async{
    await FirebaseFirestore.instance
        .collection("Investment")
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((doc) {
        setState(() {
          day = doc["day"];
          month = _Month(doc["month"]);
          year=doc["year"];
          percentage=doc["percentage"];
        });
      });
    });
  }
  void data() async{
    await FirebaseFirestore.instance
        .collection("Profile")
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((doc) {
        setState(() {
          name = doc["name"];
          value=doc["value"];
          Pyear=doc["year"];
          Pmonth = _Month(doc["month"]);
          percentage=doc["percentage"];
        });
      });
    });
    print(sumInvest);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sum();
    data();
    date();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Center(child: Image.asset('Images/blackok.png',width: 130,),),
            SizedBox(height: 25,),
            Center(
              child: Text(name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  //fontWeight: FontWeight.bold,
                ),),
            ),
            SizedBox(height: 20,),
            CircleAvatar(
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
              radius: 70,
              backgroundColor: Colors.grey,
            ),
            SizedBox(height: 25,),
            Center(
              child: Text('\$ '+value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text('Valor Comercial Estimado',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  //fontWeight: FontWeight.bold,
                ),),
            ),
            SizedBox(height: 7,),
            Center(
              child: Text('Inversiones no consideradas',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 12,
                  //fontWeight: FontWeight.bold,
                ),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Plusvalía Catastral',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                      trailing: Text(percentage+"%",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Text(Pmonth+','+Pyear,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),),
                      trailing: Text('\$ '+value,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('Updates').snapshots(),
                            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                              if(snapshot.hasData){
                                return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context,index){
                                      DocumentSnapshot ds = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                                      String _mon=_Month(ds['month']);
                                      return ListTile(
                                        title: Text(_mon+','+ds['year'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            //fontWeight: FontWeight.bold,
                                          ),),
                                        trailing: Text('\$ '+ds['value'],
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                      );
                                    }
                                );
                              }
                              else{
                                return Container(
                                  height: 100,
                                );
                              }
                            }
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Mis Inversiones',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                      trailing: Text('Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2.0,
                    ),
                    ListTile(
                      title: Text(day+" "+month+","+year,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),),
                      trailing: Text('\$ '+sumInvest.toString(),
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
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
