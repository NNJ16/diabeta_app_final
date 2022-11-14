import 'package:diabeta_app/screens/main_screen.dart';
import 'package:diabeta_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get kPrimaryColor => null;

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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Image.asset(
                  "assets/images/frontlogo.png",
                  width: 300,
                  height: 300,
                ),
              ),
              const Center(
                child: Text(
                  "DiaBeta",
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
                            return 'Please enter your email.';
                          }
                          return null;
                        },
                        controller: _userNameController,
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
                            return 'Please enter your password.';
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
                              _login();
                            }
                          },
                          child: const Text(
                            'Login',
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
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                          child: InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: "nethsera@gmail.com");
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(fontSize: 14, color: Colors.teal),
                        ),
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account,",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.teal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            " Sign Up",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 40,
                    //   ),
                    //   child: ConstrainedBox(
                    //     constraints: const BoxConstraints.tightFor(height: 40),
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const RegisterScreen()),
                    //         );
                    //       },
                    //       child: const Text(
                    //         'Register',
                    //         style: TextStyle(fontSize: 16),
                    //       ),
                    //       style: ElevatedButton.styleFrom(
                    //         shape: const StadiumBorder(),
                    //         elevation: 0,
                    //         primary: kSecondaryColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userNameController.text.toString(),
              password: _passwordController.text.toString());
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      const snackBar = SnackBar(
          content: Text("Invalid username or password."),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
