import 'package:flutter/material.dart';
import 'package:project/helpers/validators.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/widgets/form/sign-in/Custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isLoginLoading = false;

    var email = "";
    var password = "";
    var _formKey = GlobalKey<FormState>();

    setEmail(String value) {
      email = value;
    }

    setPassword(String value) {
      password = value;
    }

    setIsLoginLoading(bool value) {
      isLoginLoading = value;
    }

    login(context) async {
      if(_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print("Email: $email, Password: $password");
        setIsLoginLoading(true);

        bool result = await authService.login(email, password);

        if(result) {
          var user = await authService.getUser();
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushReplacementNamed(context, '/tabs');
        } else {
          setIsLoginLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password'),
            ),
          );
        }
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
          )
          ),
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                    CustomTextFormField(icon: Icons.email,hintText: 'Email' , onSaved: (value) => {setEmail(value!)}, validator: (value) => emailValidator(value)),
                                    const SizedBox(height: 20),
                                    CustomTextFormField(icon: Icons.lock,hintText: 'Password', obscureText: true, onSaved: (value) => {setPassword(value!)}, validator: (value) => passwordValidator(value)),
                                    const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: isLoginLoading ? null : () => login(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:  theme.primaryColor,
                                          disabledBackgroundColor: theme.primaryColor.withOpacity(0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(isLoginLoading ? 'Signing in...' : 'Sign in',  style: const TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ]
                                  )),
              
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Don\'t have an account? ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: isLoginLoading ? null : (){
                                              Navigator.pushNamed(context, "/auth/sign-up");
                                          },
                                          child: const Text(
                                            'Sign up',
                                            style: TextStyle(
                                              fontFamily: "roboto",
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
