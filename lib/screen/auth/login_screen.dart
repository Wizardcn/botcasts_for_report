import 'package:botcasts/constants.dart';
import 'package:botcasts/navigate_pages.dart';
import 'package:botcasts/screen/auth/reset_password_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
// import '../../util/aud.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const LoginPage({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers Getting value from TextField widget.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // List<AudsMock> audioList = AudsMock.myAuds();

  bool _isChecked = false; // for remember user info
  bool _isObscure = true; // for hide password

  Future logIn() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(
    //     child: CupertinoActivityIndicator(),
    //   ),
    // );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const NavigatePages(
                // audioNav: audioList[1],
                );
          },
        ),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      // print('hi');
    } on FirebaseAuthException catch (e) {
      // print('yo');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: lightRed,
          title: Text(
            "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง",
            style: TextStyle(color: red),
          ),
          content: Text(
            "กรุณาตรวจสอบใหม่อีกครั้ง",
            style: TextStyle(color: red),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "รับทราบ",
                style: TextStyle(color: red),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      body: Center(
        child: SizedBox(
          width: 305,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 200,
                  width: 250,
                  child: Image.asset(
                    'assets/img/Logo_Botcasts.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // email textfield
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'อีเมล',
                      ),
                    ),
                    // Padding(
                    // padding: const EdgeInsets.only(bottom: 10),
                    // child:
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'รหัสผ่าน',
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                        suffixIcon: IconButton(
                          color: Colors.white,
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: ()
                              // show&hide password display
                              {
                            setState(() {
                              _togglePasswordView();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                //remember me
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.black38,
                          fillColor: MaterialStateProperty.all(Colors.white),
                          value: _isChecked,
                          onChanged: _handleRemeberme),
                      const Text(
                        'จดจำรหัสผ่าน',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ResetPasswordPage()),
                          );
                        },
                        child: const Text(
                          'ลืมรหัสผ่าน?',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 115, 166, 191),
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),

                // เข้าสู่ระบบ button
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: logIn,
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            colors: [purpleColor, pinkColor],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: const Center(
                        child: Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // sigup section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        'ไม่มีบัญชีผู้ใช้?',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showSignUpPage,
                      child: const Text(
                        'ลงทะเบียน',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 115, 166, 191),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
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

  void _handleRemeberme(bool? value) {
    print("Handle Rember Me");
    _isChecked = value!;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(
      () {
        _isChecked = value;
      },
    );
  }

  void _loadUserEmailPassword() async {
    // print("Load Email");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;

      // print(remeberMe);
      // print(email);
      // print(password);
      if (remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text = email;
        _passwordController.text = password;
      }
    } catch (e) {
      // print(e);
    }
  }
}
