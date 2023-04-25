import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_field.dart';
import '../../configurations/size_config.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../utils/i_utills.dart';
import 'login_view.dart';
import 'login_vm.dart';

class ForgetPasswordView extends StatelessWidget {
  static const routeName = 'forget_screen';

  ForgetPasswordView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<LoginViewModel>(
      builder: ((context, vm, child) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.07),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forget Password',
                          style: AppStyle.headline1,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.06),
                        const Text(
                          'Enter your password',
                          style: AppStyle.headline3,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.02),
                        CustomTextField(
                          controller: vm.emailController,
                          label: 'Email',
                          hint: 'Enter your email',
                          prefix: Icons.email,
                          validator: vm.emailValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.03),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  textStyle: AppStyle.button,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                onPressed: () async {
                                  if(_formKey.currentState!.validate()){
                                  await  vm.resetPassword();
                                  if(context.mounted){
                                    iUtills().showMessage(context: context, title: 'Password reset', text: 'Please check your email');
                                    Future.delayed(const Duration(seconds: 3)).whenComplete(() {
                                      Navigator.of(context).pushReplacementNamed(LoginView.routeName);
                                    });
                                  }


                                  }

                                  //
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Submit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
