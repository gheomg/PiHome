import 'package:flutter/material.dart';
import 'package:pihole_manager/enums/protocol.dart';
import 'package:pihole_manager/globals.dart';
import 'package:pihole_manager/home.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _hostController = TextEditingController();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Server info'),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: Colors.white,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _hostController,
                    decoration: const InputDecoration(
                      label: Text('Host'),
                    ),
                  ),
                  TextFormField(
                    controller: _userController,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      label: Text('User'),
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                ]
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    Pihole pihole = Pihole(
                      protocol: Protocol.http,
                      address: _hostController.text,
                      user: _userController.text,
                      password: _passwordController.text,
                    );
                    bool result = await pihole.checkConnection();
                    if (result) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              Home(pihole: pihole),
                        ),
                      );
                    } else {
                      snackBarKey.currentState?.showSnackBar(
                        const SnackBar(
                          content: Text('Invalid credentials'),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hostController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
