import 'package:cstudents/auth/Login.dart';
import 'package:flutter/gestures.dart';

import '/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'validation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _nameCon = TextEditingController();
  var _emailCon = TextEditingController();
  var _passCon = TextEditingController();
  var _batchCon = TextEditingController();
  var _teacherIdCon = TextEditingController();
  var _studentPhoneNumber = TextEditingController();
  var _guardianPhoneNumber = TextEditingController();

  //All Validation
  bool loading = true;
  _isValid() async {
    if (loading) {
      showDialog(
          context: context,
          builder: ((context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }));
    }
    bool res = true;
    String error = "";
    if (!(res = await Validator.tIdIsValid(_teacherIdCon.text.trim()))) {
      res = false;
      error = "Teacher id not valid";
    } else if (!(res = await Validator.batchIsValid(
        _batchCon.text.trim(), _teacherIdCon.text.trim()))) {
      res = false;
      error = "Batch does not exist ";
    } else if (!(res =
            Validator.numberIsValid(_studentPhoneNumber.text.trim())) ||
        !(res = Validator.numberIsValid(_guardianPhoneNumber.text.trim()))) {
      res = false;
      error = "not a valid mobile number ";
    } else if (!(res = Validator.emailIsValid(_emailCon.text.trim()))) {
      res = false;
      error = "not a valid email ";
    } else if (!(res = Validator.passwordIsValid(_passCon.text.trim()))) {
      res = false;
      error = "password length should grater than 4 ";
    }

    if (!res) {
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 247, 109, 109),
          textColor: Color.fromARGB(255, 226, 226, 226),
          fontSize: 16.0);
      _emailCon.clear();
      _nameCon.clear();
      _passCon.clear();
      _batchCon.clear();
      _teacherIdCon.clear();
      _guardianPhoneNumber.clear();
      _studentPhoneNumber.clear();
      // navgatorKey.currentState!.popUntil((route) => route.isFirst);
      Navigator.pop(context);
    }
    return Future.value(res);
  }

  _create_database_student_instance(value) async {
    //student user instance creation
    await FirebaseFirestore.instance
        .collection('studentUsers')
        .doc(value.user!.uid)
        .set({"id": value.user!.uid, "tid": _teacherIdCon.text.trim()});

//student instance to the teacher

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_teacherIdCon.text.trim())
        .collection('student')
        .doc(value.user!.uid)
        .set({
      "id": value.user!.uid,
      "name": _nameCon.text,
      "number": int.parse(_studentPhoneNumber.text.trim() == ""
          ? "0"
          : _studentPhoneNumber.text.trim()),
      "guardianNumber": int.parse(_guardianPhoneNumber.text.trim() == ""
          ? "0"
          : _guardianPhoneNumber.text.trim()),
      "batch": _batchCon.text.trim(),
      "account": [],
      "balance": 0,
    });
  }

  signUp() async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailCon.text.trim(), password: _passCon.text.trim())
          .then((value) async {
        await _create_database_student_instance(value);
        navgatorKey.currentState!.popUntil((route) => route.isFirst);
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 247, 109, 109),
          textColor: Color.fromARGB(255, 226, 226, 226),
          fontSize: 16.0);
      _emailCon.clear();
      _nameCon.clear();
      _passCon.clear();
      _batchCon.clear();
      _teacherIdCon.clear();
      _guardianPhoneNumber.clear();
      _studentPhoneNumber.clear();
      // _passCon.dispose();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: _teacherIdCon,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(95, 157, 202, 224),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Teacher Id",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _batchCon,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(95, 157, 202, 224),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Batch",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            textInputAction: TextInputAction.next,
                            controller: _nameCon,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(95, 157, 202, 224),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _emailCon,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(95, 157, 202, 224),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _studentPhoneNumber,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(95, 157, 202, 224),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Student Phone Number",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _guardianPhoneNumber,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(95, 157, 202, 224),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Guardian Phone Number",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            onSubmitted: (value) async {
                              if (await _isValid()) {
                                await signUp();
                              }
                            },
                            controller: _passCon,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(95, 157, 202, 224),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      if (await _isValid()) {
                                        await signUp();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
