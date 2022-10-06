import 'package:botcasts/constants.dart';
import 'package:botcasts/main.dart';
import 'package:botcasts/models/app_user.dart';
import 'package:botcasts/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:botcasts/utils/validators.dart';
import 'package:google_language_fonts/google_language_fonts.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLogInPage;
  const SignUpPage({
    Key? key,
    required this.showLogInPage,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;

  AppUser? _appUserFromUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Future signUp() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(
    //     child: CupertinoActivityIndicator(),
    //   ),
    // );
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).createUserDetail(
          _usernameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
          "https://cdn.discordapp.com/attachments/983275821630357534/994459026320543764/userimg2.jpg");
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      return _appUserFromUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "*อีเมลถูกใช้ไปแล้ว",
            style: ThaiFonts.prompt(
              textStyle: TextStyle(fontSize: 16, color: red),
            ),
          ),
          padding: const EdgeInsets.all(20),
          backgroundColor: lightRed,
          behavior: SnackBarBehavior.floating,
          elevation: 20,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      body: Center(
        child: SizedBox(
          width: 305,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    width: 250,
                    child: Image.asset(
                      'assets/logo/Logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'สร้างบัญชี Botcasts',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '*จำเป็น',
                    ),
                  ),

                  //name
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'ชื่อ*',
                          ),
                        ),
                        TextFormField(
                          controller: _usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 2),
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent),
                          ),
                          validator: Validators.required("กรุณากรอกชื่อ"),
                        ),
                      ],
                    ),
                  ),

                  //email
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'อีเมล*',
                          ),
                        ),
                        TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2),
                              ),
                              errorStyle: TextStyle(color: Colors.redAccent),
                            ),
                            validator: Validators.compose([
                              Validators.required("กรุณากรอกอีเมล"),
                              Validators.email("กรุณาตรวจสอบอีเมลอีกครั้ง")
                            ])),
                      ],
                    ),
                  ),

                  //password
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'รหัสผ่าน*',
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 2),
                            ),
                            errorStyle:
                                const TextStyle(color: Colors.redAccent),
                            errorMaxLines: 3,
                            suffixIcon: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _togglePasswordView();
                                  },
                                );
                              },
                            ),
                          ),
                          validator: Validators.compose([
                            // Validators.required("กรุณากรอกรหัสผ่าน"),
                            Validators.caseError(
                                "กรุณากรอกรหัสผ่าน",
                                "ต้องมีตัวอักษรตัวใหญ่และตัวอักขระพิเศษอย่างน้อย1ตัว รหัสผ่านต้องเป็นตัวอักษร A-Z เท่านั้นและมีความยาวอย่างน้อย 8 ตัว",
                                "ต้องมีตัวอักษรตัวใหญ่อย่างน้อย 1 ตัว",
                                "ต้องมีอักขระพิเศษอย่างน้อย 1 ตัว",
                                "รหัสผ่านสั้นเกินไปต้องมีความยาวอย่างน้อย 8 ตัวอักษร",
                                "ต้องมีตัวอักษรตัวใหญ่และตัวอักขระพิเศษอย่างน้อย1ตัว",
                                "ต้องตัวอักษรพิมพ์ใหญอย่างน้อย 1 ตัว และมีความยาวอย่างน้อย 8 ตัวอักษร",
                                "*ต้องมีตัวอักขระพิเศษอย่างน้อย1ตัวและมีความยาวอย่างน้อย 8 ตัว")
                          ]),
                        ),
                      ],
                    ),
                  ),

                  //registration button
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        bool validate = _formKey.currentState!.validate();
                        if (validate) {
                          signUp();
                        }
                      },
                      child: Container(
                        height: 44,
                        width: 305,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              colors: [purpleColor, pinkColor],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        child: const Center(
                          child: Text(
                            "สร้างบัญชี",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 305,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            'มีบัญชีผู้ใช้แล้ว?',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showLogInPage,
                          child: const Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 115, 166, 191),
                                decoration: TextDecoration.underline),
                          ),
                        )
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

  void _togglePasswordView() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }
}
