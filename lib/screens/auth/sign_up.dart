import 'package:flutter/material.dart';
import 'package:project/helpers/validators.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/widgets/form/sign-in/Custom_text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isSignUpLoading = false;

    var firstName = "";
    var lastName = "";
    var email = "";
    var password = "";
    var confirmPassword = "";

    var _formKey = GlobalKey<FormState>();

    setIsSignUpLoading(bool value) {
      isSignUpLoading = value;
    }

    signUp(context) async {
      if(_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print("First Name: $firstName, Last Name: $lastName, Email: $email, Password: $password");

        if(password != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwords do not match'),
            ),
          );
          return;
        }

        setIsSignUpLoading(true);

        var message = await authService.register(email, password, firstName, lastName);

        setIsSignUpLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );

        // Call the sign up API
        // If the sign up is successful, navigate to the home page
        // If the sign up is unsuccessful, show a snackbar with the error message
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
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child:  SingleChildScrollView(
              child: Column(
                        children: [
                        const SizedBox(height: 100),
                        const Text(
              'Create an account',
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
              'Sign up to get started',
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(hintText: 'First name', onSaved: (value) => {firstName = value!}, validator: requiredFieldValidator('First name')),
                    const SizedBox(height: 20),
                    CustomTextFormField(hintText: 'Last name', onSaved: (value) => {lastName = value!}, validator: requiredFieldValidator('Last name')),
                    const SizedBox(height: 20),
                    CustomTextFormField(icon: Icons.email,hintText: 'Email', onSaved: (value) => {email = value! }, validator: (value) => emailValidator(value)),
                    const SizedBox(height: 20),
                    CustomTextFormField(icon: Icons.lock,hintText: 'Password', obscureText: true, onSaved: (value) => { password = value! }, validator: (value) => passwordValidator(value)),
                    const SizedBox(height: 20),
                    CustomTextFormField(icon: Icons.lock,hintText: 'Confirm Password', obscureText: true, onSaved: (value) => { confirmPassword = value! }, validator: (value) => passwordValidator(value)),
                    const SizedBox(height: 20),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: isSignUpLoading ? null : (){ signUp(context); },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  theme.primaryColor,
                            disabledBackgroundColor: theme.primaryColor.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(isSignUpLoading ? 'Signing up' : 'Sign up',  style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign in',
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
                        ),
                        const SizedBox(height: 10),
                      ]),
            )
          )
        ],
      ),
    );
  }
}
