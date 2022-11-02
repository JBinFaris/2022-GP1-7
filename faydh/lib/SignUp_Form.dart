import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/utilis/utilis.dart';
import 'home_page.dart';
import 'signin.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _userTypeController = TextEditingController();
  bool? _isChecked = false;
  bool? seen = false;
  String? selectedValue;


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phonenumberController.dispose();
    _userTypeController.dispose();

    super.dispose();
  }

  final List<String> userTypes = [
    "فرد",
    "منظمة تجارية",
    "منظمة خيرية",
  ];

//A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();

    if (_password.isEmpty) {
      setState(() {
        passwordStrength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        passwordStrength = 1 / 4; //string length less then 6 character
      });
    } else if (_password.length < 8) {
      setState(() {
        passwordStrength = 2 / 4; //string length greater then 6 & less then 8
      });
    } else {
      if (passValid.hasMatch(_password)) {
        // regular expression to check password valid or not
        setState(() {
          passwordStrength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          passwordStrength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  // regular expression to check if string
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;

  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(242, 214, 236, 208),
        floatingActionButton: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 70, right: 5, left: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const signInSreen();
                    }));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color.fromARGB(255, 18, 57, 20),
                  )),
            )),
        body: SingleChildScrollView(
            child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.1, 0.9],
                colors: [Color.fromARGB(142, 26, 77, 46), Color(0xffd6ecd0)]),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 80),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ClipOval(
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/imgs/logo.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ))),
                  ),
                  //email
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _emailController,
                      //field value
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                           const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                      color: Color(0xffd6ecd0),
                      width: 1.0,
                    ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: const Align(
                          alignment: Alignment.centerRight,
                          child: Text('البريد الإلكتروني'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال البربد الإلكتروني';
                        } else if (!value.contains("@") ||
                            !value.contains(".")) {
                          return 'الرجاء إدخال بريد إلكتروني صالح';
                        }
                        return null;
                      },
                    ),
                  ),
                  //username
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _usernameController, //field value
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.account_circle_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: const Align(
                          alignment: Alignment.centerRight,
                          child: Text('اسم المستخدم'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال إسم المستخدم';
                        } else if (value.length < 3) {
                          return 'إسم المستخدم يجب ان يكون اكثر من ٣ رموز';
                        } else if (value.length > 15) {
                          return 'لا يمكن لإسم المستخدم ان يكون اكثر من ١٥ رموز';
                        }

                        return null;
                      },
                    ),
                  ),
                  //password

                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _passwordController,
                      //field value
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.password_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: const Align(
                          alignment: Alignment.centerRight,
                          child: Text('كلمة المرور'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        } else {
                          //call function to check password
                          bool result = validatePassword(value);
                          if (result) {
                            return null;
                          } else {
                            return 'الرجاء إدخال كلمة مرور صحيحة';
                          }
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text( "كلمة المرور يجب ان تتكون من: حرف كبير ،حرف صغير ،رقم ورمز مميز", style: TextStyle( color: Color.fromARGB(255, 0, 0, 0) , fontSize:13, ) , textAlign: TextAlign.right, ),
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LinearProgressIndicator(
                      value: passwordStrength,
                      backgroundColor: Colors.white30.withOpacity(0.3),
                      minHeight: 5,
                      color: passwordStrength <= 1 / 4
                          ? Colors.red
                          : passwordStrength == 2 / 4
                              ? Colors.yellow
                              : passwordStrength == 3 / 4
                                  ? Colors.blue
                                  : Colors.green,
                    ),
                  ),
                  //phone number
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _phonenumberController,
                      //field value
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: const Align(
                          alignment: Alignment.centerRight,
                          child: Text('رقم الجوال'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رقم الجوال';
                        } else if (value.length != 10) {
                          return 'رقم الجوال يجب ان يكون مكون من ١٠ رموز';
                        }

                        return null;
                      },
                    ),
                  ),
                  //user type
                  Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButtonFormField<String>(
                            alignment: Alignment.centerRight,
                            value: selectedValue,
                            icon: const Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.arrow_drop_down)),
                            elevation: 16,
                            borderRadius: BorderRadius.circular(40),
                            decoration: InputDecoration(
                              // errorStyle: TextStyle( align: TextAlign.right),
                              prefixIcon: const Icon(
                                Icons.supervised_user_circle_rounded,
                                size: 30,
                                color: Color.fromARGB(255, 18, 57, 20),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              label: const Align(
                                  alignment: Alignment.center,
                                  child: Text('نوع المستخدم')),
                              // contentPadding: EdgeInsets.only(left:230),
                            ),
                            items: userTypes.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'الرجاء اختيار نوع المستخدم';
                              }
                            },
                            onChanged: (String? value) {
                              //Do something when changing the item if you want.
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                          ))),
                  //checkbox
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 2),
                      child: CheckboxListTile(
                        title: const Text(
                          "اوافق على الاحكام والشروط",
                          textAlign: TextAlign.right,
                        ),
                        value: _isChecked,
                        activeColor: const Color.fromARGB(255, 18, 57, 20),
                        onChanged: (newBool) {
                          setState(() {
                            _isChecked = newBool;
                            seen = true;
                          });
                        },
                        subtitle: seen == true && _isChecked == false
                            ? const Padding(
                                padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                                child: Text(
                                  'يجب الموافقة على الاحكام والشروط',
                                  style: TextStyle(
                                      color: Color(0xFFe53935), fontSize: 12),
                                  textAlign: TextAlign.right,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),

                  //submit button
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 2),
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                backgroundColor:
                                    const Color.fromARGB(255, 18, 57, 20),
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
                                if (_isChecked == true &&
                                    selectedValue != "" &&
                                    passwordStrength == 1) {
                                  AuthMethods()
                                      .signUpUser(
                                          role: selectedValue.toString(),
                                          username: _usernameController.text,
                                          email: _emailController.text,
                                          phoneNumber:
                                              _phonenumberController.text,
                                          password: _passwordController.text)
                                      .then((value) {
                                    if (value == "success") {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) {
                                        return const HomePage();
                                      }));
                                    }
                                    showSnackBar(value.toString(), context);
                                  });
                                }
                              },
                              child: const Text(
                                'تسجيل',
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
