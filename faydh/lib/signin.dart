import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faydh/AdminMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:faydh/SignUp_Form.dart';
import 'package:faydh/home_page.dart';
import 'package:faydh/services/auth_methods.dart';
import 'package:faydh/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'forget-password.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class signInSreen extends StatefulWidget {
  const signInSreen({Key? key}) : super(key: key);

  @override
  State<signInSreen> createState() => _signInSreenState();
}

class _signInSreenState extends State<signInSreen> {
  bool _isObscure = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  final _formKey = GlobalKey<FormState>();

void _loginUser({required String email, required String password}) async {
    String res = "حصل خطأ ما";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
       final CUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
            if(CUser != null){
             res = "success";

             final User? user = await _auth.currentUser ;
             final userID = user!.uid ;
             

             print(userID);
              
              DocumentSnapshot snap ;
              DocumentSnapshot snap2;

           
              
           snap = await FirebaseFirestore.instance
              .collection("users")
              .doc(userID)
              .get();
              print("object2");

              if(snap != null){
                 final  myrole = (snap.data() as Map<String, dynamic>)['role'];

             if(myrole == "فرد"){

               Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

             }else if (myrole =="منظمة تجارية"){
               Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

             }else if (myrole =="منظمة خيرية"){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

             }else if(myrole == "Admin"){
               Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminMain()));

             }
              }     /* else{  print("object");
                snap2 = await FirebaseFirestore.instance
                 .collection("Admins")
                 .doc(userID)
                 .get();
               
               

              if(snap2 != null){
                final  UN = (snap2.data() as Map<String, dynamic>)['username'];
                if(UN == "Admin"){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminMain()));
               }else if(UN == null){ print("object4444");}
               }

               
              }*/
             }
      } else {
        res = "الرجاء إدخال كل الحقول";
         showSnackBar(res, context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = " البريد الإلكتروني او كلمة المرور خاطئة";
      } else {
        e.code == "wrong-password";
        {
          res = "  البريد الإلكتروني او كلمة المرور خاطئة";
        }
      }
    } catch (error) {
      res = error.toString();
    }
     showSnackBar(res, context);
  }





  @override
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
                
                 SizedBox(height: 30),
                Image.asset(
                  'assets/imgs/logo.png',
                  width: 250,
                  height: 250,
                ),
                 SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني',
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
                 SizedBox(height: 30),
                TextFormField(
                  obscureText: _isObscure,
                  controller: _passwordController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    prefix: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    hintText: 'كلمة المرور',
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
                      'تسجيل الدخول',
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

                        _loginUser(
                                email: _emailController.text,
                                password: _passwordController.text);
                        
                        /* AuthMethods()
                            .loginUser(
                                email: _emailController.text,
                                password: _passwordController.text)
                            .then((value) {
                          showSnackBar(value, context);
                          if (value == "success") {


                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage())
                            );
                          }
                        });*/
                      }
                    }),
                 SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const PasswordReset();
                    }));
                  },
                  child: const Text('نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: Color(0xff201a19),
                        fontSize: 20,
                      )),
                ),
                 const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SignupForm();
                    }));
                  },
                  child: const Text('مستخدم جديد؟ تسجيل',
                      style: TextStyle(
                        color: Color.fromARGB(255, 245, 242, 241),
                        fontSize: 20,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
