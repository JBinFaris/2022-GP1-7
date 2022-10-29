import 'package:faydh/SignUp_Form.dart';
import 'package:faydh/home_page.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/signin.dart';
import 'package:faydh/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.9],
              colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 55,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Image.asset(
                  'assets/imgs/logo.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'البريد الالكتروني',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd6ecd0),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                MaterialButton(
                    elevation: 5.0,
                    color: const Color(0xff1a4d2e),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 80),
                    child: const Text(
                      "هل نسيت كلمة السر",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthMethods()
                            .resetPassword(email: _emailController.text)
                            .then((value) {
                          if (value == "success") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const signInSreen()),
                            );

                            showSnackBar(
                                "يرجى التحقق من بريدك الإلكتروني واتباع الرابط لإعادة تعيين كلمة المرور ",
                                context);
                          }
                        });
                      }
                    }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
