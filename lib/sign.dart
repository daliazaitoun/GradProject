import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test2/log.dart';

class sign extends StatefulWidget {
  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  var email, username, password;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signup() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      } // a3ml import ll firbaseauth
    } else {
      print("Not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: formstate,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Sign Up',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Create an account, it\'s free.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                //username
                TextFormField(
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onSaved: (val) {
                    username = val;
                  },
                  validator: (val) {
                    if (val!.length > 50) {
                      return "username can't be greater than 50 letter";
                    }
                    if (val.length < 4) {
                      return "username can't be smaller than 4 letter";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: ('username'),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //email
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
                      return "email can't be greater than 50 letter";
                    }
                    if (val.length < 4) {
                      return "email can't be smaller than 4 letter";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: ('Email'),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //password
                TextFormField(
                  obscureText: true,
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
                      //null el far2
                      return "password can't be greater than 50 letter";
                    }
                    if (val.length < 4) {
                      return "password can't be smaller than 4 letter";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: ('Password'),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //password check
                TextFormField(
                  obscureText: true,
                  onChanged: (String value) {
                    print(value);
                  },
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: (' Confirm Password'),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
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
                    onPressed: (() async {
                      var response = await signup();
                      print(response.user.email);
                    }),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: (() {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      log())); // navigator byn2l l page tanya
                        });
                      }),
                      child: Text('Log in'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
