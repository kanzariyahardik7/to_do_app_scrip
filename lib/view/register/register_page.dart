import 'package:app_scrip/app_dependency/get_it_depencency.dart';
import 'package:app_scrip/services/response/api_status.dart';
import 'package:app_scrip/universal_widgets/custom_button.dart';
import 'package:app_scrip/universal_widgets/instruction_widget.dart';
import 'package:app_scrip/universal_widgets/password_field_widget.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/view_models/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      RegisterViewModel registerViewModel = getIt<RegisterViewModel>();
      Map<String, dynamic> query = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      registerViewModel.register(query, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyshade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Page title
              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: blueshade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Sign up to get started",
                style: TextStyle(color: Colors.grey.shade600),
              ),
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

                      // Register button
                      Consumer<RegisterViewModel>(
                        builder: (context, value, child) {
                          return CustomButton(
                            text:
                                value.registerApiResponse.status ==
                                    Status.loading
                                ? "Please wait..."
                                : "Register",
                            height: 50,
                            backgroundColor: blue,
                            textColor: white,
                            textSize: 18,
                            onTap: () {
                              if (value.registerApiResponse.status !=
                                  Status.loading) {
                                _register();
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

              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      context.push("/login");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: blueshade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InstructionBox(),
            ],
          ),
        ),
      ),
    );
  }
}
