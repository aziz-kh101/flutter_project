import 'package:flutter/material.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/user_service.dart';
import 'package:project/widgets/form/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var user = Provider.of<UserProvider>(context).user;
    var formKey = GlobalKey<FormState>();

    var firstName = '';
    var lastName = '';
    var email = '';
    var phone = '';
    var address = '';

    void onSave() async{
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final toaster = ScaffoldMessenger.of(context);

      if(formKey.currentState!.validate()){
        formKey.currentState!.save();

        try{
          final newUserData = User(
            id: user!.id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            address: address,
          );
          final message = await userService.updateUserProfile(newUserData);

          userProvider.setUser(newUserData);

          toaster.showSnackBar(SnackBar(content: Text(message)));
        }
        catch(e){
           toaster.showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }

    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 130),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                Provider.of<UserProvider>(context, listen: false).logout();
                                Navigator.pushReplacementNamed(context, '/auth/sign-in');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.logout_outlined, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text('Logout', style: TextStyle(color: Colors.white)),
                                ],
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(label: 'first name', initialValue: user?.firstName ?? '', onSaved: (value) => firstName = value!),
                      const SizedBox(height: 10),
                      CustomTextFormField(label: 'last name', initialValue: user?.lastName ?? '', onSaved: (value) => lastName = value!),
                      const SizedBox(height: 10),
                      CustomTextFormField(label: 'email', initialValue: user?.email ?? '', onSaved: (value) => email = value!),
                      const SizedBox(height: 10),
                      CustomTextFormField(label: 'phone', initialValue: user?.phone ?? '', onSaved: (value) => phone = value!),
                      const SizedBox(height: 10),
                      CustomTextFormField(label: 'address', initialValue: user?.address ?? '', onSaved: (value) => address = value!),
                      const Expanded(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          ElevatedButton(
                            onPressed: onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Save',  style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ]),
        )
      ],
    );
  }
}

