import 'package:fl_week01/src/blocs/signup_bloc.dart';
import 'package:fl_week01/src/resources/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _showPass = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled =
          _emailController.text.isNotEmpty && _passController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.generalError ?? 'Đăng ký thất bại'),
                  ),
                );
              }
              if (state is SignUpSuccess) {
                // Đăng ký thành công, quay về trang login
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đăng ký thành công! Vui lòng đăng nhập'),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            builder: (context, state) {
              if (state is SignUpLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(100.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          "assets/images/Group.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text(
                      "Enter your credentials to continue",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: "First Name",
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        errorText: state is SignUpFailure
                            ? state.emailError
                            : null,
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      controller: _passController,
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                        labelText: "Password",
                        errorText: state is SignUpFailure
                            ? state.passwordError
                            : null,
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        suffixIcon: GestureDetector(
                          onTap: onToggleShowPass,
                          child: Icon(
                            _showPass ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: RichText(
                      text: TextSpan(
                        text: "By continuing you agree to our ",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isButtonEnabled
                              ? Colors.green
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        onPressed: _isButtonEnabled
                            ? () {
                                context.read<SignUpCubit>().signUp(
                                  email: _emailController.text.trim(),
                                  password: _passController.text.trim(),
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  username: _usernameController.text.trim(),
                                );
                              }
                            : null,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    width: double.infinity,
                    height: 50,
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
