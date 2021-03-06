import 'package:flutter/material.dart';
import 'package:sudoku/service/auth.dart';
import 'package:sudoku/share/contants.dart';
import 'package:sudoku/share/loading.dart';

class Register extends StatefulWidget {
  final Function toggleview;
  Register({this.toggleview});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field values for sign in
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Sign up in Sudoku"),
          backgroundColor:Colors.purple[400],
          elevation: 0,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: (){
                widget.toggleview();
              },
            ),
          ],
        ),
        body:Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0 ,vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration:textStyle.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? "Enter the email":null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration:textStyle.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 8  ? "Enter a password with min 8 characters":null,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  FlatButton(
                      onPressed:() async {
                        if(_formKey.currentState.validate()){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if(result == null){
                            setState(() {
                              error = "Enter the valid details";
                              loading = false;
                            });
                          }
                        }
                      },
                      color: Colors.black,
                      child: Text("Register",
                        style: TextStyle(
                            color: Colors.white
                        ),)
                  ),
                  SizedBox(height: 20.0,),
                  Text(error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),)

                ],
              ),
            )
        )
    );
  }
}
