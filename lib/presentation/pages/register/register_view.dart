
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/register/register_vm.dart';
import 'package:fu_vms/presentation/pages/register/verification_view.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_field.dart';
import '../../configurations/size_config.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../login/login_view.dart';

class RegisterView extends StatelessWidget {
  static const routeName = 'register_screen';

  RegisterView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<RegisterViewModel>(
      builder: ((context, vm, _) {
        return SafeArea(
            child: Scaffold(
                body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.07),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: AppStyle.headline1,
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.06),
                    CustomTextField(
                      controller: vm.emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      prefix: Icons.email,
                      validator: vm.emailValidator,
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.03),
                    CustomTextField(
                      controller: vm.passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      prefix: Icons.lock,
                      isHidden: vm.isHidden,
                      validator: vm.passwordValidator,
                      suffix: IconButton(
                        icon: vm.isHidden
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          vm.isHidden = !vm.isHidden;
                        },
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.03),
                    CustomTextField(
                      controller: vm.confirmPasswordController,
                      label: 'Confirm Password',
                      hint: 'Again Enter your password',
                      prefix: Icons.lock,
                      isHidden: true,
                      validator: vm.confirmPasswordValidator,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginView.routeName);
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          'Already have an account?',
                          style: AppStyle.bodyText1.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(

                              textStyle: AppStyle.button,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onPressed: () => _formKey.currentState!.validate()
                                ? vm.register().then((value) {
                                    if (value != null) {
                                      Navigator.of(context).pushReplacementNamed(VerificationView.routeName, arguments: vm.emailController.text.toString());
                                    }
                                  })
                                : null,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Sign Up'),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
      }),
    );
  }
}
