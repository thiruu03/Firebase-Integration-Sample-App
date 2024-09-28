import 'package:flutter/material.dart';
import 'package:incrementer_app/pages/signup_page.dart';
import 'package:incrementer_app/services/auth_services.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    const borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black45),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromRGBO(46, 49, 146, 0.5),
                Color.fromRGBO(27, 255, 255, 0.5),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 90,
                color: Color.fromARGB(255, 30, 89, 137),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Welcome back !!",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    enabledBorder: borderStyle,
                    border: borderStyle,
                    focusedBorder: borderStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: TextField(
                  controller: passController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    enabledBorder: borderStyle,
                    border: borderStyle,
                    focusedBorder: borderStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Authservices().loginMethod(
                      context: context,
                      email: emailController.text,
                      password: passController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 89, 137),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Doesn't have an account ? ",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const Signuppage();
                        },
                      ));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 48, 87)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
