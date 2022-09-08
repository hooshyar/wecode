import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecode/src/common/style/style.dart';
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
              Container(
                padding: EdgeInsets.all(20),
                height: 300,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.freepik.com%2Ffree-vector%2Fmobile-login-concept-illustration_114360-83.jpg&f=1&nofb=1',
                  placeholder: (context, url) => Container(),
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment(-1, -1),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                    child: Column(
                  children: [
                    CustomTextField(
                      hint: 'Email',
                      control: emailController,
                      icon: const Icon(Icons.alternate_email),
                    ),
                    CustomTextField(
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
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            'Forgot Password ?',
                            style: GeneralStyle.additionTextStyle
                                .copyWith(fontSize: 14),
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
                onPressed: () async {
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
                color: Colors.green,
                text: const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // CostumeButton(
              //   onPressed: () {
              //     debugPrint('Login');
              //   },
              //   color: const Color.fromARGB(255, 211, 211, 211),
              //   text: const Text(
              //     'Login with Google',
              //     style: TextStyle(
              //         fontWeight: FontWeight.w200,
              //         fontSize: 20,
              //         color: Color.fromARGB(255, 68, 68, 68)),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Don't Have An Account ? ",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegisterScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Register',
                        style: GeneralStyle.additionTextStyle,
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
