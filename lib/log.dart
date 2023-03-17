import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test2/sign.dart';


class log extends StatefulWidget {
  @override
  State<log> createState() => _logState();
}

class _logState extends State<log> {
  bool isObscure = true;
  var email, username, password;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signin() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  ); return credential;
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }}
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),

              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              onChanged: (String value) {
                print(value);
              },
              onFieldSubmitted: (String value) {
                print(value);
              },
              onSaved: (val) {
                email = val;
              },
              validator: (val) {
                if (val!.length > 50) {
                  return "Email can't be greater than 50 letter";
                }
                if (val.length < 4) {
                  return "Email can't be smaller than 4 letter";
                }
                return null;
              },

              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: ('Email'),
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(

              obscureText: isObscure,
              onChanged: (String value) {
                print(value);
              },
              onFieldSubmitted: (String value) {
                print(value);
              },
              onSaved: (val) {
                password = val;
              },
              validator: (val) {
                if (val!.length > 50) {
                  return "password can't be greater than 50 letter";
                }
                if (val.length < 4) {
                  return "password can't be smaller than 4 letter";
                }
                return null;
              },

              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: ('Password'),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(onPressed: () {
                  setState((
                      ) {
                    isObscure=! isObscure;
                  });
                },
                  icon: isObscure ? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              color: Colors.blue,
              child: MaterialButton(
                onPressed: (() async{
                  var user = await signin();
                }),
                child: Text('Login', style: TextStyle(color: Colors.white),),
              ),
            ),
            Column(
              children: [
                Text('Or Log in with:'),
                //google button
                // InkWell(
                //   onTap: () {},
                //   child: Ink(
                //     color: Color(0xFF397AF3),
                //     child: Padding(
                //       padding: EdgeInsets.all(10),
                //       child: Wrap(
                //         crossAxisAlignment: WrapCrossAlignment.center,
                //         children: [
                //           Icon(Icons.android), // <-- Use 'Image.asset(...)' here
                //           SizedBox(width: 30),
                //           Text('Sign in with Google'),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                TextButton(onPressed: (() {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    => sign())
                    );// navigator byn2l l page tanya

                  });
                }), child: Text('Register Now!'),

                ),
              ],
            )
          ],
        ),
      ),
    );
  }}
