import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class AddInvestment extends StatefulWidget {
  const AddInvestment({Key? key}) : super(key: key);

  @override
  State<AddInvestment> createState() => _AddInvestmentState();
}

class _AddInvestmentState extends State<AddInvestment> {
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  final CollectionReference postRef= FirebaseFirestore.instance.collection('Investment');
  TextEditingController name=TextEditingController();
  TextEditingController value=TextEditingController();
   String day="7";
   String month="12";
   String year="2022";
  //AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  File? _image;
  ImagePicker _picker = ImagePicker();
  Future camerImage() async
  {
    final pickedFile= await _picker.pickImage(source: ImageSource.camera);
    if(pickedFile!=null){
      setState(() {
        _image=File(pickedFile.path);
      });
    }
  }
  Future galleryImage() async
  {
    final pickedFile= await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      setState(() {
        _image=File(pickedFile.path);
      });
    }
  }
  //Dialoge Box
  void Dialogue(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      camerImage();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text('Camera')
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      galleryImage();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text('Gallery')
                    ),
                  )
                ],
              ),
            ),
          );
        }

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Add Investments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            //camera
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: InkWell(
                  onTap: (){
                    Dialogue(context);
                  },
                  child: Container(
                    height:140,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(70)
                    ),
                    child: _image != null ? ClipRect(
                      child: Image.file(
                        _image!.absolute,
                        fit: BoxFit.fill,
                        //height: 140,
                        //width: 140,
                        ),
                    ):Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(70)
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 13),
            //   child: Center(
            //     child: Container(
            //       height: 140,
            //       width: 140,
            //       decoration: BoxDecoration(
            //         color: Colors.black,
            //         borderRadius: BorderRadius.circular(70),
            //       ),
            //       child: Icon(Icons.camera_alt_rounded,color: Colors.white,),
            //     ),
            //   ),
            // ),
            //fields
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
                child: Text("  Value",
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
                 selectedDay: 7, // optional
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
            SizedBox(height: 40,),
            InkWell(
              onTap: ()async{
                try{
                  ToastMessage("wait");
                  int date=DateTime.now().microsecondsSinceEpoch;
                  firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/plusvalia$date');
                  UploadTask uploadTask=ref.putFile(_image!.absolute);
                  await Future.value(uploadTask);
                  var newUrl=await ref.getDownloadURL();
                  postRef.doc().set(
                      {
                        'image':newUrl.toString(),
                        'name':name.text.toString(),
                        'value':value.text.toString(),
                        'day':day,
                        'month':month,
                        'year':year,

                      }).then((value) {
                    ToastMessage('Upload Successfully!');
                    Navigator.pop(context);
                  }).catchError((error){
                    ToastMessage(error.toString());
                  });
                }catch(e){
                  ToastMessage(e.toString());
                }
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
                      Text('Confirm',
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
