import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecode/src/screens/auth/forgot_pass_screen.dart';
import 'package:wecode/src/screens/auth/handler_screen.dart';
import 'package:wecode/src/screens/auth/registerScreen.dart';
import 'package:wecode/src/services/auth_service.dart';
import 'package:wecode/widget/costume_button.dart';
import 'package:wecode/widget/costume_textField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.freepik.com%2Ffree-vector%2Fmobile-login-concept-illustration_114360-83.jpg&f=1&nofb=1'),
              const Align(
                alignment: Alignment(-1, -1),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                    child: Column(
                  children: [
                    CostumeTextField(
                      hint: 'Email',
                      control: emailController,
                      icon: const Icon(Icons.alternate_email),
                    ),
                    CostumeTextField(
                      hint: 'Password',
                      control: passwordController,
                      icon: const Icon(Icons.lock_outline),
                    ),
                    Align(
                      alignment: const Alignment(1, 1),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ForgotPassScreen(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              color:  Color.fromARGB(255, 42, 146, 231),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              const SizedBox(
                height: 15,
              ),
              CostumeButton(
                onPressedd: () async {
                  //First step auth with firebase auth
                  await authService
                      .signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text)
                      .then((value) => Get.to(() => const HandlerScreen())

                          //   .then(

                          // // Second step get the user data from firestore
                          // (userCredential) {
                          //   //TODO: check userCredential user not to be null

                          //   return FirebaseFirestore.instance
                          //       .collection('users')
                          //       .doc(userCredential!.user!.uid)
                          //       .get()
                          //       .then(
                          //     (value) {
                          //       //third step : save the user information into the provider
                          //       context.read<UserProvider>().setWeCodeUser(
                          //             WeCodeUser.fromSnapShot(value),
                          //           );
                          //     },
                          //   );
                          // },

                          );
                },
                color: const Color.fromARGB(255, 42, 146, 231),
                text: const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CostumeButton(
                onPressedd: () {
                  debugPrint('Login');
                },
                color: const Color.fromARGB(255, 211, 211, 211),
                text: const Text(
                  'Login with Google',
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 20,
                      color: Color.fromARGB(255, 68, 68, 68)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Don't Have An Account ? ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Color.fromARGB(255, 21, 116, 224),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
