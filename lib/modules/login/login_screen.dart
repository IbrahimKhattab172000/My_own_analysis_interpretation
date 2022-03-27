// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unused_local_variable, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  ///hkhkhkh Look yasta don't forget and put it after the [Widget build(BuildContext context]
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defaultTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      if (formKey.currentState!.validate()) {
                        return "Email address must not be empty";
                      }
                    },
                    lable: "Email Address",
                    prefix: Icons.email,
                    onSubmit: (value) {},
                    onChange: (value) {},
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    isPassword: isPassword,
                    validator: (value) {
                      if (formKey.currentState!.validate()) {
                        return "Password must not be empty";
                      }
                    },

                    ///This suffixPressed we will be passed to the IconButton's onPress
                    suffixPressed: () {
                      setState(() {
                        ///Don't put it like that => [isPassword != isPassword;],
                        isPassword = !isPassword;
                      });
                    },
                    lable: "Password",
                    prefix: Icons.lock,
                    suffix: isPassword
                        ? Icons.remove_red_eye_sharp
                        : Icons.remove_red_eye_outlined,
                    onSubmit: (value) {},
                    onChange: (value) {},
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                    text: "Login",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Register now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
