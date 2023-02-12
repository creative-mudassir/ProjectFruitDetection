import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/login.dart';
import 'package:project/round_button.dart';
import 'package:project/utils/utils.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;
  @override
  State<Signup> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<Signup> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  var obscureText = true;
  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 254, 252, 239),
                Color.fromARGB(255, 238, 231, 175),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/applogo.png',
                      scale: 6,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'FRUIT',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 3, 3, 3)),
                        ),
                        Text(
                          'DETECTION',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 5, 5),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                    child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                )),
                const SizedBox(
                  height: 02,
                ),
                // const Center(
                //     child: Text(
                //   'We are here to support you financially and \n provide you ecnomical tickets.',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 16, color: Color(0xff4c5980)),
                // )),
                const SizedBox(
                  height: 50,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                fillColor: const Color(0xfff8f9fa),
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.alternate_email,
                                  color: Color.fromARGB(255, 255, 1, 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 255, 0, 0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 255, 1, 1)),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                fillColor: const Color(0xfff8f9fa),
                                filled: true,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: obscureText
                                      ? const Icon(
                                          Icons.visibility_off_outlined,
                                          color: Color.fromARGB(255, 255, 0, 0),
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Color.fromARGB(255, 2, 168, 2),
                                        ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 255, 0, 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 255, 0, 0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 255, 1, 1)),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 70,
                ),
                RoundButton(
                  loading: loading,
                  title: 'Sign Up',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                const SizedBox(
                  height: 150,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                      'Already have an account?  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Rubik Regular',
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    )),
                    TextButton(
                      child: const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Rubik Medium',
                            fontSize: 15,
                            color: Color.fromARGB(246, 255, 0, 0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login(
                                      controller: passwordController,
                                    )));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
