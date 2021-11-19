import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/screen1.dart';

import 'addparking/parkingprovider.dart';
import 'showall.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth=FirebaseAuth.instance;
  
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page "),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.add_chart),
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>ShowAll()));
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40)
              ),
              margin: EdgeInsets.all(20),
              child: TextFormField(
                controller: email,
                obscureText: false,
                decoration:InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40)
                  ),
                  prefixIcon: Icon(Icons.mail_outline),
                  hintText:"E-Mail"

                ),

              ),
            ),
            Container(

              margin: EdgeInsets.all(20),
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration:InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40)
                  ),
                  hintText:"Password"

                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(

              width: 170,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child: TextButton(onPressed: (){
              
              login();
              
            }, child: Text("Log In",style: TextStyle(
                color: Colors.white
              ),),))
          ],
        ),
      ),
    );



  }

  void login() async{
    await _auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) => {

      Fluttertoast.showToast(msg: "correct",backgroundColor: Colors.green,textColor: Colors.white,gravity: ToastGravity.BOTTOM),
        alertDialog()
    });
  }
  void alertDialog() {
    AlertDialog alert=AlertDialog(
      title:       Center(
        child: Text("Welcome to Parking System"),
      ),

      actions: [

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Are You Parking Provider or User ?"),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProviderDetails()));


                }, child: Text("Provider")),
                ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));}, child: Text("User")),
              ],
            ),

          ],
        )
      ],

    );
    showDialog(context: context, builder: (BuildContext context){
      return alert;
    });
  }

}
