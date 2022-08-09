import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    controller: emailController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: passwordController,
                  ),
                ],
              )),
            ),
            Container(
              width: 150,
              child: ElevatedButton(
                child: Text('Login', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
