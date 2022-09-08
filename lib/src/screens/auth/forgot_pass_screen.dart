import 'package:flutter/material.dart';
import 'package:wecode/src/screens/auth/login_screen.dart';
import 'package:wecode/src/services/auth_service.dart';
import 'package:wecode/widget/costume_button.dart';

import '../../../widget/costume_textField.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController emailController = TextEditingController();
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://image.freepik.com/free-vector/forgot-password-concept-isolated-white_263070-194.jpg'),
            Column(
              children: const [
                Align(
                  alignment: Alignment(-1, -1),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Forgot Passowrd ?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment(-1, -1),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Don't worry it happens, please enter email associated with your account ",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                ),
              ],
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
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CostumeButton(
              onPressed: () {
                auth.forgetPassword(email: emailController.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                );
              },
              color: const Color.fromARGB(255, 42, 146, 231),
              text: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
