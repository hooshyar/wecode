import 'package:flutter/material.dart';
import 'package:wecode/src/screens/auth/forgot_pass_screen.dart';
import 'package:wecode/widget/costume_button.dart';
import '../../../widget/costume_textField.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const ForgotPassScreen(),
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
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.freepik.com%2Ffree-vector%2Fforgot-password-concept-flat-illustration_203587-4.jpg&f=1&nofb=1'),
            Column(
              children: const [
                Align(
                  alignment: Alignment(-1, -1),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Reset Password',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    CostumeTextField(
                      hint: 'New Password',
                      control: newPasswordController,
                      icon: const Icon(Icons.lock_outlined),
                    ),
                    CostumeTextField(
                      hint: 'Confirm your Password',
                      control: confirmPasswordController,
                      icon: const Icon(Icons.lock_outlined),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CostumeButton(
              onPressedd: () {},
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
