import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../bloc/login_bloc.dart';
import '../widgets/shapes.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        log("State is $state");
        if (state is LoginAuthenticated) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => MyHomePage(data: state.data)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
                onPressed: () {
                  context.read<LoginBloc>().add(
                      LoginInit(emailController.text, passwordController.text));
                },
                backgroundColor: const Color.fromARGB(255, 72, 195, 252),
                child: state is LoginLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.arrow_forward)),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: -(MediaQuery.of(context).size.width * 0.20),
                  right: -(MediaQuery.of(context).size.width * 0.25),
                  child: Transform.rotate(
                    angle: -math.pi / 6,
                    child: CustomPaint(
                      size: const Size(400, 300),
                      painter: MyPainter(const Color.fromARGB(255, 1, 63, 114),
                          Colors.transparent, 0),
                    ),
                  ),
                ),
                Positioned(
                  top: -(MediaQuery.of(context).size.width * 0.20),
                  left: -(MediaQuery.of(context).size.width * 0.30),
                  child: Transform.rotate(
                    angle: math.pi / 1.3,
                    child: CustomPaint(
                      size: const Size(400, 300),
                      painter: MyPainter(const Color.fromARGB(255, 55, 55, 149),
                          Colors.transparent, 0),
                    ),
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(60)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0)
                                  ]),
                              child: TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    focusColor: Colors.grey,
                                    hintText: 'Username',
                                    prefixIcon: Icon(Icons.person_outline),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60)))),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(60)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 2.0,
                                        spreadRadius: 2.0)
                                  ]),
                              child: TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    focusColor: Colors.grey,
                                    hintText: 'Password',
                                    prefixIcon:
                                        Icon(Icons.lock_outline_rounded),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(60)))),
                              ),
                            ),
                            state is LoginFailed
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8.0),
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot Password?',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    )),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(
                                      height: 50, width: 120),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(60),
                                                        bottomRight:
                                                            Radius.circular(
                                                                60))))),
                                    onPressed: () {},
                                    child: const Text(
                                      'Register',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 182, 12, 0)),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
