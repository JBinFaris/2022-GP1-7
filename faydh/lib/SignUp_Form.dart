import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  final _UserTypeController = TextEditingController();
  bool? _isChecked = false;
  bool? seen = false;
  String? SelectedValue;

  final List<String> UserTypes = [
    'فرد',
    'منظمة تجارية',
    'منظمة خيرية',
    'مشرف',
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phonenumberController.dispose();
    _UserTypeController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Scaffold(
        backgroundColor: Color.fromARGB(242, 214, 236, 208),
        floatingActionButton: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 70, right: 5, left: 5),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios_new,
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
                              'images/Faydh.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ))),
                  ),
                  //email
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _emailController, //field value
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 18, 57, 20)),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: Align(
                          alignment: Alignment.centerRight,
                          child: Text('البريد الإلكتروني'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        fillColor: Colors.white70,
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
                        prefixIcon: Icon(
                          Icons.account_circle_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 18, 57, 20)),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: Align(
                          alignment: Alignment.centerRight,
                          child: Text('اسم المستخدم'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        fillColor: Colors.white70,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال إسم المستخدم';
                        } else if (value.length < 3) {
                          return 'إسم المستخدم يجب ان يكون اكثر من ٣ رموز';
                        } else if (value.length > 8) {
                          return 'لا يمكن لإسم المستخدم ان يكون اكثر من ٨ رموز';
                        }

                        return null;
                      },
                    ),
                  ),
                  //password
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _passwordController, //field value
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 18, 57, 20)),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: Align(
                          alignment: Alignment.centerRight,
                          child: Text('كلمة المرور'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        fillColor: Colors.white70,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        } else if (value.length < 8) {
                          return 'كلمة المرور يجب ان تكون اكثر من ٨ رموز';
                        } else if (value.length > 15) {
                          return 'لا يمكن لكلمة المرور ان تكون اكثر من ١٥ رمز';
                        }

                        return null;
                      },
                    ),
                  ),
                  //phone number
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _phonenumberController, //field value
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 18, 57, 20),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 18, 57, 20)),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        label: Align(
                          alignment: Alignment.centerRight,
                          child: Text('رقم الجوال'),
                        ),

                        // contentPadding: EdgeInsets.only(left:230),
                        fillColor: Colors.white70,
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
                            value: SelectedValue,
                            icon: Align(
                                alignment: Alignment.centerLeft,
                                child: const Icon(Icons.arrow_drop_down)),
                            elevation: 16,
                            borderRadius: BorderRadius.circular(40),
                            decoration: InputDecoration(
                              // errorStyle: TextStyle( align: TextAlign.right),
                              prefixIcon: Icon(
                                Icons.supervised_user_circle_rounded,
                                size: 30,
                                color: Color.fromARGB(255, 18, 57, 20),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 18, 57, 20)),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              label: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('نوع المستخدم')),
                              // contentPadding: EdgeInsets.only(left:230),
                              fillColor: Colors.white70,
                            ),
                            items: UserTypes.map<DropdownMenuItem<String>>(
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
                                SelectedValue = value!;
                              });
                            },
                            onSaved: (value) {
                              SelectedValue = value.toString();
                              //a
                            },
                          ))),
                  //checkbox
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 2),
                      child: CheckboxListTile(
                        title: Text(
                          "اوافق على الاحكام والشروط",
                          textAlign: TextAlign.right,
                        ),
                        value: _isChecked,
                        activeColor: Color.fromARGB(255, 18, 57, 20),
                        onChanged: (newBool) {
                          setState(() {
                            _isChecked = newBool;
                            seen = true;
                          });
                        },
                        subtitle: seen == true && _isChecked == false
                            ? Padding(
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
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                backgroundColor:
                                    Color.fromARGB(255, 18, 57, 20),
                                shape: StadiumBorder(),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
                              },
                              child: Text(
                                'تسجيل',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
        )),
      ),
    ));
  }
}
/*    const SizedBox(height: 10),
                 DropdownButtonFormField2(
                 decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(2.0, 0.5, 2.0, 0.5),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(Icons.supervised_user_circle_rounded , size: 30, color: Color.fromARGB(255, 18, 57, 20) ,),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                label: Align(alignment: Alignment.centerRight,
                child: Text('نوع المستخدم', style: TextStyle(fontSize: 15), ),) ,
                 ),
                  isExpanded: true,
                  icon: Align(
                    alignment: Alignment.centerLeft,
                    child:Icon(
                         Icons.arrow_drop_down,
                        color: Color.fromARGB(255, 18, 57, 20),
                         size: 30, 
                         ) ,) ,
                alignment: Alignment.centerRight,
                 buttonHeight: 60,
                 buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                 dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                 ),
                 items: UserTypes.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            
                          ),
                        ),
                      ))
                      .toList(),
                      validator: (value) {
                     if (value == null) {
                     return 'الرجاء اختيار نوع المستخدم';
                     }
                     }, onChanged: (value) {
                //Do something when changing the item if you want.
                     },
                    onSaved: (value) {
                    SelectedValue = value.toString();
                    
                     },
                    ),*/
