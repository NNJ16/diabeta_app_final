import 'package:diabeta_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success = false;
  String _userEmail = "";

  get kPrimaryColor => null;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Image.asset(
                  "assets/images/frontlogo.png",
                  width: 300,
                  height: 300,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40, color: Colors.teal),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        controller: _nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          labelText: 'Full Name',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        obscureText: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 45),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _register();
                            }

                            // if (_userNameController.text == "amal" &&
                            //     _passwordController.text == "1234") {

                            // } else {
                            //   const snackBar = SnackBar(
                            //       content: Text("Invalid username or password."),
                            //       backgroundColor: Colors.red);
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(snackBar);
                            // }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 0,
                            primary: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                            },
                            child: const Text(
                              " Login",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),

                    // FutureBuilder(
                    //   future: Authentication.initializeFirebase(context),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasError) {
                    //       return const Text('Error initializing Firebase');
                    //     } else if (snapshot.connectionState ==
                    //         ConnectionState.done) {
                    //       return const Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 40),
                    //         child: GoogleSignInButton(),
                    //       );
                    //     }
                    //     return Container(
                    //       width: 20,
                    //       child: const CircularProgressIndicator(
                    //         valueColor: AlwaysStoppedAnimation<Color>(
                    //           Colors.blue,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString());
          User? user = userCredential.user;
          if(user != null){
            user.updateDisplayName(_nameController.text.toString());
          }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const snackBar = SnackBar(
            content: Text("The password provided is too weak."),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        const snackBar = SnackBar(
            content: Text("The account already exists for that email."),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }
}
