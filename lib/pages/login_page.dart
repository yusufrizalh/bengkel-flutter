import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(80, 0, 0, 1),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.6,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 12,
              shadowColor: Colors.black,
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormBuilderTextField(
                      key: _emailFieldKey,
                      autofocus: true,
                      name: 'email',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email address',
                        prefixIcon: Icon(Icons.email),
                        helperText: '*Please enter a valid email address',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 18),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        helperText: '*Please enter a valid password',
                      ),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      color: Color.fromRGBO(8, 0, 0, 1),
                      onPressed: () {
                        // Validate and save the form values
                        _formKey.currentState?.saveAndValidate();
                        debugPrint(_formKey.currentState?.value.toString());

                        // On another side, can access all field values without saving form with instantValues
                        _formKey.currentState?.validate();
                        debugPrint(
                          _formKey.currentState?.instantValue.toString(),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
