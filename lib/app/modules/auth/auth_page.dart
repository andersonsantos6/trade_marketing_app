import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trade_marketing_app/app/core/consts.dart';
import 'package:trade_marketing_app/app/core/shared/text_form.dart';
import 'package:trade_marketing_app/app/modules/auth/auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _authController = Modular.get<AuthController>();

  Future<void> validate() async {
    if (_formKey.currentState!.validate()) {
      await _authController.login(context);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Trade Result'),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/logo-mundo-wap.jpg',
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomTextFormField(
                    initialValue: 'teste.mobile',
                    onChanged: _authController.authStore.setEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o email';
                      }
                      return null;
                    },
                    labelText: 'Email',
                    hintText: 'Informe o email',
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  CustomTextFormField(
                    initialValue: "1234",
                    onChanged: _authController.authStore.setPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                    labelText: 'Senha',
                    hintText: 'Informe a senha',
                    prefixIcon: const Icon(Icons.lock),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: validate,
                      child: const Text('Entrar'),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
