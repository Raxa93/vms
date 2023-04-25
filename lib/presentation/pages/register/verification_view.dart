// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/register/register_vm.dart';

import '../../../locator.dart';
import '../../configurations/size_config.dart';
import '../../constants/app_styles.dart';
import '../brewery/brewery_main.dart';
import '../login/login_view.dart';

class VerificationView extends StatefulWidget {
  static const routeName = 'verification_screen';
  String email;

  VerificationView({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final RegisterViewModel _vm = locator<RegisterViewModel>();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _vm.sendLinkToEmail();
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      checkEmailVerified();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
        child: Center(
          child: Text('An email has been sent to ${widget.email}. Please verify link will expire in 30 seconds ',style: AppStyle.headline2),
        ),
      ),
    );
  }

  void checkEmailVerified() async {
   await _vm.checkEmailVerification().then((value) {
      if (value == true) {
        debugPrint('Email is verified $value');
        timer.cancel();
        _vm.onModelDestroy();
        Navigator.of(context).pushReplacementNamed(BreweryMainView.routeName);

      } else {
        debugPrint('No verified $value');
        timer.cancel();
        _vm.onModelDestroy();
        Navigator.of(context).pushReplacementNamed(LoginView.routeName);
      }
    });
  }
}
