// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:abdullah_mansour/modules/shop_app/register/shop_register_screen.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';

class ShopLoginScreen extends StatefulWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //!hkhkhkh Look yasta don't forget and put it after the [Widget build(BuildContext context]

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "LOGIN",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                Text(
                  "Login now to browse our hot offers",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(height: 30),
                defaultTextFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your email address";
                    }
                    return "";
                  },
                  border: OutlineInputBorder(),
                  lable: "Email address",
                  prefix: Icons.email_outlined,
                ),
                SizedBox(height: 30),
                defaultTextFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null) {
                      return "Password is too short";
                    }
                    return "";
                  },
                  lable: "Password",
                  border: OutlineInputBorder(),
                  prefix: Icons.lock_outline,
                  suffixPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  suffix: isPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  isPassword: isPassword,
                ),
                SizedBox(height: 30),
                defaultButton(
                  function: () {},
                  text: "login",
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    defaultTextButton(
                      text: "Register now",
                      onPress: () {
                        navigateTo(
                          context: context,
                          widget: ShopRegisterScreen(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
