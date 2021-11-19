import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/loginpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  CollectionReference student =
      FirebaseFirestore.instance.collection('parking');
  final _auth = FirebaseAuth.instance;

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController Mobile = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Page"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: TextFormField(
                onChanged: (s) {},
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    prefixIcon: Icon(Icons.account_circle_rounded),
                    hintText: "Name"),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      prefixIcon: Icon(Icons.email_sharp),
                      hintText: "E-Mail"),
                )),
            Container(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  prefixIcon: Icon(Icons.password_sharp),
                  hintText: "Password",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    prefixIcon: Icon(Icons.smartphone_sharp),
                    hintText: "Mobile No"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 35,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                ),
                Container(
                  height: 35,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextButton(
                      onPressed: () {
                        addUser();
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> addUser() async {
    await _auth
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) => {postDetail()})
        .catchError((e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.CENTER);


    });
  }

  postDetail() async {
    User? user = _auth.currentUser;
    Model model = new Model();
    model.email = user!.email;
    model.uid = user.uid;
    model.name = name.text;

    await student.doc(user.uid).set(model.toMap());
    Fluttertoast.showToast(msg: "Account is created Successfully");
    print("Successfully");
  }


}

class Model {
  String? uid;
  String? name;
  String? email;

  Model({this.uid, this.name, this.email});

  factory Model.fromMap(map) {
    return Model(uid: map["uid"], email: map["email"], name: map["name"]);
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'name': name};
  }
}
