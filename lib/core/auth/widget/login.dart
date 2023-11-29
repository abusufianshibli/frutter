import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frutter/common/utils/route/route.dart';
import 'package:frutter/common/widgets/custom_card.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../provider/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _username = TextEditingController();
  final _pass = TextEditingController();

  bool _isObscure = true;

  Future? _future;

void loginWithUsername(AuthProvider authData){
 _future= authData.loginWithUserName().then((value){
   if(value){
     Navigator.pushNamedAndRemoveUntil(context,  RouteName.home, (route) => false);
   }
 });
}
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text('Frutter',style: TextStyle(fontSize: 30),),
                const SizedBox(height: 20),
                CustomCard(
                  backgroundColor: Colors.grey.shade200,
                  elevation: 3,
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Email',),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.white)
                            ),
                            child: TextFormField(
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 18),
                              controller: _username,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 16),
                                border: InputBorder.none,
                                hintText: 'User Name',
                                hintStyle: TextStyle(color: Colors.black),
                                // labelText: 'username',
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text('Password',),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.white)

                            ),
                            child: TextFormField(
                              controller: _pass,
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 16),
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    }),
                              ),
                              textInputAction: TextInputAction.go,
                              obscureText: _isObscure,
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          FutureBuilder(
                            future: _future,
                            builder: (context, snapshot) {
                              return SizedBox(
                                height: 60,
                                child: CustomButton(
                                  borderRadius: 18,
                                  showProgressIndicator: snapshot.connectionState == ConnectionState.waiting,
                                  onPressed: _username.text == '' || _pass.text == '' ? null
                                      : (){
                                    setState(() {
                                      loginWithUsername(authData);
                                    });
                                  },
                                  text: 'Login',
                                ),
                              );
                            },
                          ),
                        ]),
                  ),
                ),
                const SizedBox(height: 30),
                Text('Forgot a password?',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
