import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_ui/screens/home_screen.dart';
import 'package:flutter_login_ui/screens/reset_screen.dart';
import 'package:flutter_login_ui/widgets.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  bool checkBoxValue = false;
  bool loading = false;
  bool isObscure = true;
  String? btnText;

  void _validateFields() {
    if (_emailEditingController.text.isEmpty &&
        _passwordEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email and password are missing'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    } else if (_emailEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email is missing'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    } else if (_passwordEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password is missing'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    } else {
      setState(() {
        loading = true;
      });
      checkButton();
    }
  }

  void checkButton() {
    if (btnText == 'Login') {
      login();
    } else {
      register();
    }
  }

  void register() async {
    try {
      // UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailEditingController.text,
          password: _passwordEditingController.text);
      // setState(() {
      //   loading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('SignUp Successfully!!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // setState(() {
        //   loading = false;
        // });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      } else if (e.code == 'email-already-in-use') {
        // setState(() {
        //   loading = false;
        // });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      // setState(() {
      //   loading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Unknown error occured.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
      );
      print(userCredential.credential);
      print(userCredential.user);
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No user found for that email.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Wrong password provided for that user.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Personal Blog Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // Container(
              //   height: 150,
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage('logoo.png'), fit: BoxFit.fill)),
              // ),
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordEditingController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.blue,
                      value: checkBoxValue,
                      side: const BorderSide(color: Colors.blue),
                      onChanged: (bool? value) {
                        setState(() {
                          checkBoxValue = value!;
                        });
                      }),
                  const Text('Remember me'),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ResetScreen()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? circularProgressBar()
                  : SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              btnText = 'Login';
                            });
                            _validateFields();
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          btnText = 'Signup';
                        });
                        _validateFields();
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ))
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      ' Or ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: SignInButton(
                        Buttons.Facebook,
                        text: "Facebook",
                        elevation: 10,
                        onPressed: () {
                          signInWithFacebook()
                              .then((UserCredential user) => {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 50,
                    child: SignInButton(
                      Buttons.Google,
                      text: "Google",
                      elevation: 10,
                      onPressed: () {
                        {
                          signInWithGoogle().then((UserCredential user) {});
                        }
                      },
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
