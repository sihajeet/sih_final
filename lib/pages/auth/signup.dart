import 'package:flutter/material.dart';
import 'package:sih_final/pages/auth/login.dart';

import '../../constant/constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final selectlanguageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: const AssetImage(tWelcomeScreenImage),
                  height: size.height * 0.2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: tEmail,
                            hintText: tEmail,
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            label: Text(tEmail),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                            label: Text(tPhoneNo),
                            prefixIcon: Icon(Icons.numbers),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                            label: Text(tPassword),
                            prefixIcon: Icon(Icons.fingerprint),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: selectlanguageController,
                        decoration: const InputDecoration(
                            label: Text('language'),
                            prefixIcon: Icon(Icons.language),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: tFormHeight - 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //get user and pass it to controller
                              // final user = UserModel(
                              //   email: controller.email.text.trim(),
                              //   password: controller.password.text.trim(),
                              //   fullName: controller.fullName.text.trim(),
                              //   phoneNo: controller.phoneNo.text.trim(),
                              // );

                              // // email and passwword authentication
                              // SignUpController.instance.registerUser(
                              //     controller.email.text.trim(),
                              //     controller.password.text.trim());

                              //yaha par add kia hain maine function,baaki screens mein dikkat hori hain

                              // Get.to(() =>HomeStudent() );
                            }
                          },
                          child: Text(tSignup.toUpperCase()),
                        ),
                      ),
                      const Center(child: Text("OR")),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Image(
                            image: AssetImage(tGoogleLogoImage),
                            width: 20.0,
                          ),
                          label: Text(tSignInWithGoogle.toUpperCase()),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen())),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'already have account ?',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(text: tLogin.toUpperCase())
                          ])),
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
    );
  }
}
