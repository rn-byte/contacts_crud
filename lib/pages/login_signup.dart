import 'package:crud_op/pages/home.dart';
import 'package:crud_op/util/outline_input_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPass = true;
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPass = '';
  bool logSign = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(logSign ? 'Login' : 'SignUp'),
        centerTitle: true,
      ),
      body: _loginForm(),
    );
  }

  Form _loginForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: inputDecoration(
                  hText: 'Enter Your Email',
                  icon: Icons.email_outlined,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Enter email';
                  } else if (!(value.toString().contains(RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")))) {
                    return 'Invalid Email';
                  } else {
                    debugPrint(userEmail);
                    return null;
                  }
                },
                onSaved: (value) {
                  userEmail = value.toString();
                  //debugPrint(userEmail);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: showPass,
                decoration: inputDecoration(
                  sIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                    child: const Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),
                  hText: 'Enter Your Password',
                  icon: Icons.lock_outline,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Enter password';
                  } else {
                    debugPrint(userPass);
                    return null;
                  }
                },
                onSaved: (value) {
                  userPass = value.toString();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        _formKey.currentState!.save();
                        if (!logSign) {
                          _signUp(userEmail, userPass);
                          setState(() {});
                        } else {
                          _login(userEmail, userPass);
                        }
                      } else {
                        debugPrint('Error in provided value');
                      }
                    },
                    child: Text(
                      logSign ? 'Login' : 'SignUp',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(logSign
                      ? "Don't have an Account ? "
                      : "Already hava an account ? "),
                  InkWell(
                    onTap: () {
                      setState(() {
                        logSign = !logSign;
                      });
                    },
                    child: Text(
                      logSign ? " Signup " : " Login ",
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(String userEmail, String userPass) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPass);

      debugPrint('Login Success');
      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    } on FirebaseAuthException catch (e) {
      debugPrint('${e.code} login Firebase Exception');
    } catch (e) {
      debugPrint('$e login exception' as String?);
    }
  }

  Future<void> _signUp(String userEmail, String userPass) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: userPass);

      debugPrint('sign up success');
      setState(() {
        logSign = !logSign;
      });
    } on FirebaseAuthException catch (e) {
      debugPrint('${e.code} signUp firebase exception');
    } catch (e) {
      debugPrint("$e here" as String?);
    }
  }
}
