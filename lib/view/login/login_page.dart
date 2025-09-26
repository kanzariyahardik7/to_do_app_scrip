import 'package:app_scrip/app_dependency/get_it_depencency.dart';
import 'package:app_scrip/services/response/api_status.dart';
import 'package:app_scrip/universal_widgets/custom_button.dart';
import 'package:app_scrip/universal_widgets/password_field_widget.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: "eve.holt@reqres.in",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "cityslicka",
  );

  void _login() {
    if (_formKey.currentState!.validate()) {
      LoginViewModel loginViewModel = getIt<LoginViewModel>();
      Map<String, dynamic> query = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      loginViewModel.login(query, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyshade100,
      appBar: AppBar(backgroundColor: greyshade100),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Page title
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: blueshade800,
                ),
              ),
              const SizedBox(height: 8),
              Text("Login to continue", style: TextStyle(color: greyshade600)),
              const SizedBox(height: 40),

              // Card container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: black,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      PasswordField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Login button
                      Consumer<LoginViewModel>(
                        builder: (context, value, child) {
                          return CustomButton(
                            text:
                                value.loginApiResponse.status == Status.loading
                                ? "Please wait..."
                                : "Login",
                            height: 50,
                            backgroundColor: blue,
                            textColor: white,
                            textSize: 18,
                            onTap: () {
                              if (value.loginApiResponse.status !=
                                  Status.loading) {
                                _login();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Don’t have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: blueshade800,
                        fontWeight: FontWeight.bold,
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
