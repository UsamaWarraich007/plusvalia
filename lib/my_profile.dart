import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final CollectionReference postRef= FirebaseFirestore.instance.collection('Profile');
  final CollectionReference postRef1= FirebaseFirestore.instance.collection('Updates');
  TextEditingController name=TextEditingController();
  TextEditingController value=TextEditingController();
  TextEditingController percentage=TextEditingController();
  String day="7";
  String month="12";
  String year="2022";
  void data() async{
    await FirebaseFirestore.instance
        .collection("Profile")
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((doc) {
       setState(() {
         name.text = doc["name"];
         value.text=doc["value"];
         percentage.text=doc["percentage"];
         day=doc["day"];
         month=doc["month"];
         year=doc["year"];
       });
      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,

                  ),),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  //suffixIconColor: Colors.black,
                  // iconColor: Colors.black,
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: Colors.grey
                  ),
                  hintText: 'Enter Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Value",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,

                  ),),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: value,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  labelText: 'Value',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    //fontSize: 14,
                  ),
                  hintText: 'Enter Value',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Date",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,

                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: DropdownDatePicker(
                inputDecoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    // enabledBorder: const OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: 1.0),
                    // ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25))
                ), // optional
                isDropdownHideUnderline: true, // optional
                //isFormValidator: true, // optional
                startYear: 2010, // optional
                endYear: 2035, // optional
                width: 5, // optional
                selectedDay: 6, // optional
                selectedMonth: 12, // optional
                selectedYear: 2022, // optional
                onChangedDay: (value) => day=value!,
                onChangedMonth: (value) => month=value!,
                onChangedYear: (value) => year=value!,
                // boxDecoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(30),), // optional
                // showDay: false,// optional
                // dayFlex: 2,// optional
                // locale: "zh_CN",// optional
                //hintDay: 'Day', // optional
                // hintMonth: 'Month', // optional
                // hintYear: 'Year', // optional
                // hintTextStyle: TextStyle(color: Colors.grey), // optional
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.center,
                child: Text("Plusvalia Catastral Anual",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,

                  ),),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              //color: Colors.red,
              width: MediaQuery.of(context).size.width*0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Percentage Sugerido:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,

                    ),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.3,
                    child: TextField(
                      controller: percentage,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                       // labelText: 'Value',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          //fontSize: 14,
                        ),
                        //hintText: 'Enter Value',
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            InkWell(
              onTap: ()async{
                try{
                  ToastMessage("wait");
                  //int date=DateTime.now().microsecondsSinceEpoch;
                  // firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/plusvalia$date');
                  // UploadTask uploadTask=ref.putFile(_image!.absolute);
                  // await Future.value(uploadTask);
                  // var newUrl=await ref.getDownloadURL();
                  postRef.doc("xMg5vmH6UN4cdJFl4xP6").update(
                      {
                        //'image':newUrl.toString(),
                        'name':name.text.toString(),
                        'percentage':percentage.text.toString(),
                        'value':value.text.toString(),
                        'day':day,
                        'month':month,
                        'year':year,

                      }).then((value) {
                    ToastMessage('Update Successfully!');
                    //Navigator.pop(context);
                  }).catchError((error){
                    ToastMessage(error.toString());
                  });
                }catch(e){
                  ToastMessage(e.toString());
                }
                postRef1.doc().set({
                  'value':value.text.toString(),
                  'month':month,
                  'year':year,
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width*0.9,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(width: 100,),
                      Container(
                        //alignment: Alignment.centerRight,
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Icon(
                          Icons.done,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void ToastMessage(String message){
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
