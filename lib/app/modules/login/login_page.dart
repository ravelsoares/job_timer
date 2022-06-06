import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0XFF0092b9),
          Color(0XFF0167b2),
        ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(height: screenSize.height * 0.1),
              SizedBox(
                width: screenSize.width * 0.8,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Image.asset('assets/images/google.png'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
