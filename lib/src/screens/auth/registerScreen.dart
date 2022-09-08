// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/common/widgets/loading_indicator.dart';
import 'package:wecode/src/providers/user_provider.dart';

import 'package:wecode/src/screens/auth/login_screen.dart';
import 'package:wecode/src/screens/create_profile_screen/create_profile.dart';
import 'package:wecode/src/services/auth_service.dart';
import 'package:wecode/src/services/firestore_service.dart';
import 'package:wecode/widget/costume_button.dart';
import 'package:wecode/widget/costume_textField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  AuthService authService = AuthService();
  FireStoreService fireStoreService = FireStoreService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const LoadingIndicator()
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                        'https://media.istockphoto.com/vectors/register-account-submit-access-login-password-username-internet-vector-id1281150061?k=20&m=1281150061&s=170667a&w=0&h=r2JoluPHXUIdKb2cNnvcwFg7BIIf-SrBDFdoU0fZBnc='),
                    const Align(
                      alignment: Alignment(-1, -1),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Form(
                          child: Column(
                        children: [
                          CustomTextField(
                            hint: 'User Name',
                            control: userNameController,
                            icon: const Icon(Icons.person),
                          ),
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
                          CustomTextField(
                            hint: 'Phone Number',
                            control: phoneNumberController,
                            icon: const Icon(Icons.phone),
                          ),
                        ],
                      )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CostumeButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        //first step firebase auth to register user with the auth
                        await authService
                            .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text)
                            .then((userCredential) async {
                          //second step
                          if (userCredential != null &&
                              userCredential.user != null) {
                            await fireStoreService
                                .addUserWithInitialInformationToDB(
                                    user: userCredential.user!,
                                    userName: userNameController.text,
                                    phoneNumber: phoneNumberController.text)
                                .then((weCodeUser) {
                              // Provider.of<UserProvider>(context, listen: false)
                              //     .setWeCodeUser(weCodeUser);

                              // basically the same as above
                              context
                                  .read<UserProvider>()
                                  .setWeCodeUser(weCodeUser);

                              setState(() {
                                isLoading = false;
                              });

                              Get.to(() => const CreateProfileScreen(
                                    isUpdate: false,
                                  ));
                            });
                            setState(() {
                              isLoading = false;
                            });
                          }

                          // navigate to next screen

                          // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> CreateProfileScreen()));
                        });
                      },
                      color: const Color.fromARGB(255, 42, 146, 231),
                      text: const Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Already Have An Account ? ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              'Login',
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
