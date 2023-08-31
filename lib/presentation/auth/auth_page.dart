import 'package:chat_app_tg/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_app_tg/presentation/auth/mixin/auth_mixin.dart';
import 'package:chat_app_tg/presentation/users/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return Scaffold(
                backgroundColor: Colors.amber,
                body: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter your Email...',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter your password...',
                            prefixIcon: Icon(Icons.lock_open),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LoginWithEmailEvent(
                              email: emailController.text,
                              password: passwordController.text));
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignUpEvent(
                              email: emailController.text,
                              password: passwordController.text));
                        },
                        child: const Text('Sign Up'),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(const GoogleEvent());
                        },
                        child: const Text('With Google'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
